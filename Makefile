#!make

.PHONY: build build/image clean clone

include .sample.env
include .env

REPO_NAME = $(shell git rev-parse --abbrev-ref HEAD)
BASE_IMAGE_TAG = $(REPO_REG)$(REPO_OWNER)/base-$(REPO_NAME):$(BASE_REPO_VERSION)
DOCKER_IMAGE_RESULT = $(shell docker images -q $(BASE_IMAGE_TAG) 2>/dev/null)
APP_PATH = $(REPO_DOMAIN)/$(REPO_OWNER)/$(REPO_NAME)

build/image:
	@docker build --build-arg APP_PATH=$(APP_PATH) . -t $(BASE_IMAGE_TAG)
 
build:
	@[ "$(DOCKER_IMAGE_RESULT)" = "" ] && make -s build/image || true

clean:
	@docker rmi $(BASE_IMAGE_TAG) || true

clone:
	@rm -rf sandbox && cp -r repo sandbox && cp dir/main.go sandbox/ && cd sandbox && \
		find . -type f -name "*.*" -print0 | xargs -0 sed -i \
			-e 's|{{MAKE_REPO_NAME}}|$(REPO_NAME)|g' \
			-e 's|{{MAKE_APP_PATH}}|$(APP_PATH)|g' \
			-e 's|{{MAKE_BASE_IMAGE_TAG}}|$(BASE_IMAGE_TAG)|g' && \
		git init && git add .
