package library

import (
	"context"
	"errors"
	"fmt"

	"github.com/ra341/gonlnk/pkg/config"
)

type DownloaderTrigger interface {
	TriggerDownloader()
}

type Service struct {
	cf config.Provider[Config]
	db Store
	ds DownloaderTrigger
}

func New(
	cf config.Provider[Config],
	db Store,
	ds DownloaderTrigger,
) *Service {
	return &Service{
		cf: cf,
		db: db,
		ds: ds,
	}
}

func (s *Service) Add(ctx context.Context, links ...string) error {
	var errs error
	for _, link := range links {
		lk := Link{
			Url:    link,
			Status: Queued,
		}

		err := s.db.Add(ctx, &lk)
		if err != nil {
			errs = errors.Join(errs, fmt.Errorf("failed to add %s: %w", link, err))
			continue
		}

	}

	s.ds.TriggerDownloader()
	return errs
}
