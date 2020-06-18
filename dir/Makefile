#!make
.PHONY: dev fmt test build

build:
	@/bin/godev gen routes --from swagger.yaml --to server/routes.go

dev:
	@bash scripts/watch.sh test

fmt:
	@go fmt ./...

test:
	@go test ./... -v --coverprofile=output/cover.txt; \
		go tool cover -html=output/cover.txt -o output/cover.html

build:
	@go build -o output/executable main.go
