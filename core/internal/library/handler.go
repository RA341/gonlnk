package library

import (
	"context"
	"net/http"

	"connectrpc.com/connect"
	v1 "github.com/ra341/gonlnk/generated/library/v1"
	"github.com/ra341/gonlnk/generated/library/v1/v1connect"
	"github.com/ra341/gonlnk/pkg/listutils"
)

type Handler struct {
	srv *Service
}

func NewHandler(srv *Service) (string, http.Handler) {
	h := &Handler{
		srv: srv,
	}

	return v1connect.NewLibraryServiceHandler(h)
}

func (h *Handler) Add(ctx context.Context, req *connect.Request[v1.AddRequest]) (*connect.Response[v1.AddResponse], error) {
	links := req.Msg.Link

	err := h.srv.Add(ctx, links...)
	if err != nil {
		return nil, err
	}

	return connect.NewResponse(&v1.AddResponse{}), nil
}

func (h *Handler) Retry(ctx context.Context, c *connect.Request[v1.RetryRequest]) (*connect.Response[v1.RetryResponse], error) {
	lk := Link{
		Title:        c.Msg.Link.Title,
		Url:          c.Msg.Link.Url,
		DownloadPath: c.Msg.Link.DownloadPath,
		Status:       Queued,
		Err:          c.Msg.Link.Err,
	}
	lk.ID = uint(c.Msg.Link.Id)

	err := h.srv.db.Update(ctx, &lk)
	if err != nil {
		return nil, err
	}

	h.srv.ds.TriggerDownloader()

	return connect.NewResponse(&v1.RetryResponse{}), nil
}

func (h *Handler) List(ctx context.Context, req *connect.Request[v1.ListRequest]) (*connect.Response[v1.ListResponse], error) {
	list, err := h.srv.db.List(ctx)
	if err != nil {
		return nil, err
	}

	resp := listutils.ToMap(list, func(t Link) *v1.Link {
		return &v1.Link{
			Id:           int64(t.ID),
			Title:        t.Title,
			Url:          t.Url,
			DownloadPath: t.DownloadPath,
			Status:       t.Status.String(),
			Err:          t.Err,
		}
	})

	return connect.NewResponse(&v1.ListResponse{
		Links: resp,
	}), nil
}
