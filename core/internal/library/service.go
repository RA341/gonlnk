package library

type Service struct {
	downloadFolder string
}

func NewService(downloadFolder string) *Service {
	return &Service{
		downloadFolder: downloadFolder,
	}
}
