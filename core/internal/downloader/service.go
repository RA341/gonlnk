package downloader

import (
	"context"
	"encoding/base64"
	"fmt"
	"io"
	"mime"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"sync/atomic"
	"time"

	"github.com/google/uuid"
	"github.com/ra341/gonlnk/internal/library"
	"github.com/ra341/gonlnk/pkg/config"
	"github.com/rs/zerolog/log"
	"golang.org/x/sync/errgroup"
)

type StatusUpdater interface {
	Update(ctx context.Context, link *library.Link) error
	ListWithState(ctx context.Context, status library.Status) ([]library.Link, error)
}

type Downloader struct {
	eg *errgroup.Group

	cf config.Provider[Config]
	su StatusUpdater

	downloaderRunning atomic.Bool
}

func New(
	cfg config.Provider[Config],
	su StatusUpdater,
) *Downloader {
	eg := &errgroup.Group{}
	eg.SetLimit(cfg().MaxDownloads)

	return &Downloader{
		cf: cfg,
		su: su,
		eg: eg,
	}
}

func (d *Downloader) CheckDownloadSchedule() {
	timer := time.NewTicker(d.cf().GetCheckInterval())

	for {
		select {
		case <-timer.C:
			d.TriggerDownloader()
		default:
		}
	}
}

func (d *Downloader) TriggerDownloader() {
	if d.downloaderRunning.Swap(true) {
		return
	}

	go d.StartDownloader()
}

func (d *Downloader) StartDownloader() {
	defer d.downloaderRunning.Store(false)

	log.Info().Msg("starting downloader")

	ctx := context.Background()

	for {
		queued, err := d.su.ListWithState(ctx, library.Queued)
		if err != nil {
			log.Warn().Err(err).Msg("failed to list queued items")
			return
		}

		if len(queued) == 0 {
			log.Info().Msgf("no queued items found, stopping downloader")
			return
		}

		log.Info().Msgf("found %d queued items, downloading...", len(queued))

		for _, link := range queued {
			d.eg.Go(func() error {
				linkToDownload := link
				err := d.StartDownload(&linkToDownload)
				if err != nil {
					linkToDownload.Status = library.Error
					linkToDownload.Err = err.Error()

					if err := d.su.Update(ctx, &linkToDownload); err != nil {
						log.Warn().Err(err).Msg("failed to update link status")
					}
				}

				return nil
			})
		}
	}
}

func (d *Downloader) StartDownload(link *library.Link) error {
	ctx := context.Background()

	cfg := d.cf()
	encodedURL := base64.URLEncoding.EncodeToString([]byte(link.Url))
	tempDir := filepath.Join(cfg.TempFolder, encodedURL)

	if err := os.MkdirAll(tempDir, 0755); err != nil {
		return fmt.Errorf("failed to create temp directory: %w", err)
	}

	tempFile := filepath.Join(tempDir, uuid.NewString()+".tmp")

	link.Status = library.Downloading
	if err := d.su.Update(ctx, link); err != nil {
		return err
	}

	relayURL, err := url.Parse(cfg.YtRelayUrl)
	if err != nil {
		return fmt.Errorf("failed to parse relay url: %w", err)
	}

	q := relayURL.Query()
	q.Set("url", link.Url)
	relayURL.RawQuery = q.Encode()

	req, err := http.NewRequestWithContext(ctx, "GET", relayURL.String(), nil)
	if err != nil {
		return fmt.Errorf("failed to create request: %w", err)
	}

	if cfg.YtRelayKey != "" && cfg.YtRelayKey != "-" {
		req.Header.Set("Authorization", "Bearer "+cfg.YtRelayKey)
	}

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return fmt.Errorf("failed to execute request: %w", err)
	}
	defer func(Body io.ReadCloser) {
		err := Body.Close()
		if err != nil {
			log.Warn().Err(err).Msg("failed to close response body")
		}
	}(resp.Body)

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("relay service returned status: %s", resp.Status)
	}

	return d.finalizeDownload(link, tempFile, resp, ctx, encodedURL)
}

func (d *Downloader) finalizeDownload(link *library.Link, tempFile string, resp *http.Response, ctx context.Context, encodedURL string) error {
	// Create temp file for downloading
	out, err := os.Create(tempFile)
	if err != nil {
		return fmt.Errorf("failed to create temp file: %w", err)
	}
	defer func() {
		err := out.Close()
		if err != nil {
			log.Warn().Err(err).Msg("failed to close temp file")
			return
		}

		err = os.Remove(tempFile)
		if err != nil {
			log.Warn().Err(err).Msg("failed to remove temp file")
			return
		}
	}()

	if _, err := io.Copy(out, resp.Body); err != nil {
		return fmt.Errorf("failed to save file content: %w", err)
	}

	// Extraction of filename from headers
	filename := "download"
	if cd := resp.Header.Get("Content-Disposition"); cd != "" {
		_, params, err := mime.ParseMediaType(cd)
		if err == nil {
			if f, ok := params["filename"]; ok {
				filename = f
			}
		}
	}

	link.Title = filename
	if err := d.su.Update(ctx, link); err != nil {
		log.Warn().Err(err).Msg("failed to update link title")
	}

	// Move to final location
	finalDir := filepath.Join(d.cf().FinalFolder, encodedURL)
	if err := os.MkdirAll(finalDir, 0755); err != nil {
		return fmt.Errorf("failed to create final directory: %w", err)
	}

	finalPath := filepath.Join(finalDir, filename)
	if err := os.Rename(tempFile, finalPath); err != nil {
		// If rename fails (e.g. cross-device), copy and remove
		if err := copyFile(tempFile, finalPath); err != nil {
			return fmt.Errorf("failed to copy file to final location: %w", err)
		}
	}

	link.Status = library.Complete
	link.DownloadPath = finalPath
	return d.su.Update(ctx, link)
}

func copyFile(src, dst string) error {
	in, err := os.Open(src)
	if err != nil {
		return err
	}
	defer func(in *os.File) {
		err := in.Close()
		if err != nil {
			log.Warn().Err(err).Msg("failed to close file")
		}
	}(in)

	out, err := os.Create(dst)
	if err != nil {
		return err
	}
	defer func(out *os.File) {
		err := out.Close()
		if err != nil {
			log.Warn().Err(err).Msg("failed to close file")
		}
	}(out)

	_, err = io.Copy(out, in)
	return err
}
