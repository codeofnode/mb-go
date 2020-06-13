#!make

.PHONY: build build/image clean

include .sample.env
include .env

IMAGE_TAG = $(REPO_REG)$(REPO_OWNER)/$(REPO_NAME):$(REPO_VERSION)
DOCKER_IMAGE_RESULT = $(shell docker images -q $(IMAGE_TAG) 2>/dev/null)

build/image:
	@docker build . -t $(IMAGE_TAG)
 
build:
	[ "$(DOCKER_IMAGE_RESULT)" = "" ] && make -s build/image || true

clean:
	@docker rmi $(IMAGE_TAG) || true

