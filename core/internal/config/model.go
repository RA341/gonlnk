package config

import (
	"github.com/ra341/gonlnk/internal/downloader"
	"github.com/ra341/gonlnk/internal/library"
)

type Config struct {
	Server     Server            `yaml:"server"`
	GonLnk     GonLnk            `yaml:"gonLnk"`
	Library    library.Config    `yaml:"library"`
	Downloader downloader.Config `yaml:"downloader"`
}

type GonLnk struct {
	ConfigDir string `yaml:"configDir" default:"./config" env:"CONFIG_FOLDER" help:"application config" folder:""`
}

type Server struct {
	Port           int      `yaml:"port" default:"9293" env:"SERVER_PORT" help:"server port"`
	AllowedOrigins []string `yaml:"allowedOrigins" default:"*" env:"ALLOWED_ORIGINS" help:"allowed origins in CSV"`
}
