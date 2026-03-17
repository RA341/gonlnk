package app

import (
	"fmt"
	"reflect"

	"github.com/ra341/gonlnk/internal/config"
	"github.com/ra341/gonlnk/internal/database"
	"github.com/ra341/gonlnk/internal/downloader"
	"github.com/ra341/gonlnk/internal/library"

	"github.com/ra341/gonlnk/pkg/logger"
	"github.com/rs/zerolog/log"
)

type App struct {
	Library    *library.Service
	Downloader *downloader.Downloader
}

func NewApp() *App {
	conf := config.New()
	initConf := conf.Get()
	if initConf == nil {
		log.Fatal().Msg("config is nil, THIS SHOULD NEVER HAPPEN")
		return nil
	}
	logger.InitConsole("debug", true)

	db, err := database.New(initConf.GonLnk.ConfigDir)
	if err != nil {
		log.Fatal().Err(err).Msg("failed to connect to database")
	}

	libDb := library.NewStoreGorm(db)
	downSrv := downloader.New(
		func() *downloader.Config {
			return &conf.Get().Downloader
		},
		libDb,
	)
	libSrv := library.New(
		func() *library.Config {
			return &conf.Get().Library
		},
		libDb,
		downSrv,
	)

	a := &App{
		Library:    libSrv,
		Downloader: downSrv,
	}

	return a
}

func (a *App) VerifyServices() error {
	val := reflect.ValueOf(a).Elem()
	typ := val.Type()

	for i := 0; i < val.NumField(); i++ {
		field := val.Field(i)
		fieldName := typ.Field(i).Name

		// We only care about pointers (services)
		if field.Kind() == reflect.Pointer && field.IsNil() {
			return fmt.Errorf("critical error: service '%s' was not initialized", fieldName)
		}
	}
	return nil
}
