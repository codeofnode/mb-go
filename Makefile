#!make

.PHONY: build build/image clean

include .sample.env
include .env

IMAGE_TAG = $(REPO_REG)$(REPO_OWNER)/$(REPO_NAME):$(REPO_VERSION)
DOCKER_IMAGE_RESULT = $(shell docker images -q $(IMAGE_TAG) 2>/dev/null)
APP_PATH = $(REPO_DOMAIN)/$(REPO_OWNER)/$(REPO_NAME)

build/image:
	@docker build --build-arg APP_PATH=$(APP_PATH) . -t $(IMAGE_TAG)
 
build:
	[ "$(DOCKER_IMAGE_RESULT)" = "" ] && make -s build/image || true

clean:
	@docker rmi $(IMAGE_TAG) || true

