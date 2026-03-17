FROM ghcr.io/ra341/dfw AS front

WORKDIR /app

COPY ui .

RUN flutter pub get

RUN flutter build web --wasm

FROM golang:1 AS back

WORKDIR /app

COPY core .

RUN go mod download

RUN CGO_ENABLED=0 go build -o gonlnk "./cmd/gonlnk"

RUN chmod +x ./gonlnk

FROM scratch

WORKDIR /app

COPY --from=back /app/gonlnk gonlnk

COPY --from=front /app/build/web web

ENTRYPOINT ["./gonlnk"]
