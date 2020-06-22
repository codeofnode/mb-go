#!make
.PHONY: dev fmt test build build/rt


build/rt:
	@sed -i -n 1,35p internal/server/routes.go; /bin/godev gen routes --from configs/swagger.yaml --to internal/server/routes.go

dev:
	@bash scripts/watch.sh test

fmt:
	@go fmt ./...

test: build/rt
	@go test ./... -v --coverprofile=output/cover.txt; \
		go tool cover -html=output/cover.txt -o output/cover.html

build: build/rt
	@go build -o output/executable main.go
