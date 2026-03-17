package app

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"time"

	"github.com/go-chi/chi/v5"
	"github.com/go-chi/chi/v5/middleware"
	"github.com/go-chi/docgen"
	"github.com/ra341/gonlnk/internal/library"
	"github.com/rs/zerolog/log"
	"golang.org/x/net/http2"
	"golang.org/x/net/http2/h2c"
)

type Server struct {
	*App
	ctx context.Context
}

func NewServer() {
	server := Server{
		ctx: context.Background(),
	}
	server.App = NewApp()

	r := chi.NewRouter()
	r.Use(middleware.Logger)
	server.RegisterRoutes(r)

	finalMux := WithCors(r, []string{})

	portNum := 9293
	port := fmt.Sprintf(":%d", portNum)
	log.Info().Str("port", port).Msg("Starting server...")

	srv := &http.Server{
		Addr: port,
		Handler: h2c.NewHandler(
			finalMux,
			&http2.Server{},
		),
	}

	go func() {
		var err error
		err = srv.ListenAndServe()
		if err != nil && !errors.Is(err, http.ErrServerClosed) {
			log.Fatal().Err(err).Msg("Error starting server")
		}
	}()

	<-server.ctx.Done()

	log.Info().Msg("Context cancelled. Shutting down server...")
	shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()

	if err := srv.Shutdown(shutdownCtx); err != nil {
		log.Error().Err(err).Msg("Error occurred while shutting down server")
		return
	}

	log.Info().Msg("Server gracefully stopped.")
}

func (s *Server) RegisterRoutes(mux *chi.Mux) {
	mux.Mount(
		"/api/",
		http.StripPrefix("/api", s.ApiRouter(mux)),
	)

	mux.Handle("/*", http.FileServer(http.Dir("./web/")))

	mux.Get("/ping", func(w http.ResponseWriter, r *http.Request) {
		_, err := w.Write([]byte("welcome to gonlnk zone"))
		if err != nil {
			log.Warn().Err(err).Msg("Error writing response")
		}
	})
}

func (s *Server) ApiRouter(globRouter *chi.Mux) chi.Router {
	r := chi.NewRouter()
	s.docsRouter(globRouter, r)
	path, handler := library.NewHandler(s.Library)
	r.Handle(path+"*", handler)

	return r
}

func (s *Server) docsRouter(globRouter *chi.Mux, r *chi.Mux) chi.Router {
	return r.Route("/docs", func(r chi.Router) {
		r.Get("/md", func(w http.ResponseWriter, r *http.Request) {
			res := docgen.MarkdownRoutesDoc(globRouter, docgen.MarkdownOpts{
				ProjectPath: "github.com/RA341/golnk",
				Intro:       "golnk api docs",
			})

			_, err := w.Write([]byte(res))
			if err != nil {
				log.Warn().Err(err).Msg("Error writing response")
			}

			return
		})

		r.Get("/json", func(w http.ResponseWriter, r *http.Request) {
			res := docgen.JSONRoutesDoc(globRouter)

			_, err := w.Write([]byte(res))
			if err != nil {
				log.Warn().Err(err).Msg("Error writing response")
			}

			return
		})
	})
}
