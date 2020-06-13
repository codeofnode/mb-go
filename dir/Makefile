#!make
.PHONY: dev fmt test

dev:
	@bash scripts/watch.sh test

fmt:
	@go fmt ./...

test:
	@go test ./... -v --coverprofile=output/cover.txt; \
		go tool cover -html=output/cover.txt -o output/cover.html
