package downloader

import (
	"time"

	"github.com/rs/zerolog/log"
)

type Config struct {
	TempFolder  string `yaml:"tempFolder" default:"./temp" env:"TEMP_FOLDER" help:"store the temporary in progress files" folder:""`
	FinalFolder string `yaml:"finalFolder" default:"./downloads" env:"DOWNLOAD_FOLDER" help:"final download folder" folder:""`

	MaxDownloads  int    `yaml:"maxDownloads" default:"5" env:"MAX_DOWNLOADS" help:"max concurrent downloads"`
	CheckInterval string `yaml:"checkInterval" default:"6h" env:"CHECK_INTERVAL" help:"periodic check for queued downloads"`

	YtRelayUrl string `yaml:"ytRelayUrl" default:"-" env:"YTRELAY_URL" help:"url for yt relay instance"`
	YtRelayKey string `yaml:"ytRelayKey" default:"-" env:"YTRELAY_KEY" help:"api key for yt relay instance"`
}

func (c *Config) GetCheckInterval() time.Duration {
	duration, err := time.ParseDuration(c.CheckInterval)
	if err != nil {
		log.Warn().Err(err).Str("interval", c.CheckInterval).Msg("invalid check interval, using default")
		return 6 * time.Hour
	}

	return duration
}
