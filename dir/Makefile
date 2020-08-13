#!make
.PHONY: dev fmt test build

dev:
	@bash scripts/watch.sh test

fmt:
	@go fmt ./...

test:
	@go test ./... -v --coverprofile=output/cover.txt; \
		go tool cover -html=output/cover.txt -o output/cover.html

build:
	@cp Dockerfile output/; CGO_ENABLED=0 go build -o output/executable main.go
