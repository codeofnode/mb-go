#!make
.PHONY: dev fmt test build build/rt


build/rt:
	@if ! grep -q "Routes{" internal/server/routes.go; then /bin/godev gen routes --from configs/swagger.yaml --to internal/server/routes.go; fi

dev:
	@bash scripts/watch.sh test

fmt:
	@go fmt ./...

test: build/rt
	@go test ./... -v --coverprofile=output/cover.txt; \
		go tool cover -html=output/cover.txt -o output/cover.html

build: build/rt
	@go build -o output/executable main.go
