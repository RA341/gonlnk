package app

import (
	"fmt"
	"reflect"

	"github.com/ra341/gonlnk/pkg/logger"
)

type App struct {
}

func NewApp() *App {
	//conf := config.New()
	//c := conf.Get()
	//if c == nil {
	//	log.Fatal().Msg("config is nil THIS SHOULD NEVER HAPPEN")
	//	return nil
	//}

	logger.InitConsole("debug", true)

	a := &App{}

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
