package library

import (
	"context"

	"gorm.io/gorm"
)

//go:generate enumer -type=Status -output=gen_enum_status.go
type Status int

const (
	Unknown Status = iota
	Queued
	Downloading
	Complete
	Error
)

type Link struct {
	gorm.Model
	Title        string
	Url          string
	DownloadPath string

	Status Status
	Err    string
}

type Store interface {
	List(ctx context.Context) ([]Link, error)
	ListWithState(ctx context.Context, status Status) ([]Link, error)

	Add(ctx context.Context, link *Link) error
	Delete(ctx context.Context, link *Link) error
	Update(ctx context.Context, link *Link) error
}
