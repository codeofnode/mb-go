#!make
.PHONY: dev fmt test build build/rt


build/rt:
	@head -n35 dir/internal/server/a.go > dir/internal/server/routes.go; /bin/godev gen routes --from configs/swagger.yaml --to internal/server/routes.go

dev:
	@bash scripts/watch.sh test

fmt:
	@go fmt ./...

test: build/rt
	@go test ./... -v --coverprofile=output/cover.txt; \
		go tool cover -html=output/cover.txt -o output/cover.html

build: build/rt
	@go build -o output/executable main.go
