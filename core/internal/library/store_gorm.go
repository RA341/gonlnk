package library

import (
	"context"

	"github.com/rs/zerolog/log"
	"gorm.io/gorm"
)

type StoreGorm struct {
	db *gorm.DB
}

func NewStoreGorm(db *gorm.DB) *StoreGorm {
	err := db.AutoMigrate(&Link{})
	if err != nil {
		log.Fatal().Err(err).Msg("Could not migrate links")
	}
	return &StoreGorm{db: db}
}

func (s StoreGorm) Get(ctx context.Context, id uint) (Link, error) {
	var link Link
	err := s.db.WithContext(ctx).Where("id = ?", id).First(&link).Error
	return link, err
}

func (s StoreGorm) Add(ctx context.Context, link *Link) error {
	return s.db.WithContext(ctx).Create(link).Error
}

func (s StoreGorm) Delete(ctx context.Context, link *Link) error {
	return s.db.WithContext(ctx).Delete(link).Error
}

func (s StoreGorm) List(ctx context.Context) ([]Link, error) {
	var links []Link
	err := s.db.WithContext(ctx).Find(&links).Error
	return links, err
}

func (s StoreGorm) ListWithState(ctx context.Context, status Status) ([]Link, error) {
	var links []Link
	err := s.db.WithContext(ctx).Where("status = ?", status).Find(&links).Error
	return links, err
}

func (s StoreGorm) Update(ctx context.Context, link *Link) error {
	return s.db.WithContext(ctx).Model(link).Updates(link).Error
}
