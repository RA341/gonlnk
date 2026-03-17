package library

import (
	"net/http"
	"strconv"
)

type HandlerHttp struct {
	srv *Service
}

func NewHandlerHttp(srv *Service) (string, http.Handler) {
	h := &HandlerHttp{srv: srv}

	mux := http.NewServeMux()
	mux.HandleFunc("/serve/{id}", h.serveFile)

	return "/files", mux
}

func (h *HandlerHttp) serveFile(w http.ResponseWriter, r *http.Request) {
	id := r.PathValue("id")
	atoi, err := strconv.Atoi(id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	file, err := h.srv.db.Get(r.Context(), uint(atoi))
	if err != nil {
		w.WriteHeader(http.StatusNotFound)
		w.Write([]byte(err.Error()))
		return
	}

	http.ServeFile(w, r, file.DownloadPath)
}
