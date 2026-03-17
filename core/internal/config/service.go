package config

import (
	"github.com/ra341/gonlnk/pkg/argos"
	"github.com/ra341/gonlnk/pkg/config"
)

const EnvPrefix = "GONLNK"
const Yml = "gonlnk.yml"
const YmlPathEnv = "GONLNK_CONFIG_YML_PATH"

func New() *config.Service[Config] {
	prefixer := argos.WithPrefixer(EnvPrefix)

	return config.New[Config](
		prefixer,
		YmlPathEnv,
		Yml,
	)
}
