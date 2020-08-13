#!make

.PHONY: build build/image build/sh clean clone

include .sample.env
-include .env

REPO_NAME := $(shell git rev-parse --abbrev-ref HEAD)
BASE_IMAGE_TAG = $(REPO_REG)$(REPO_OWNER)/base-$(REPO_NAME):$(BASE_REPO_VERSION)
DOCKER_IMAGE_RESULT = $(shell docker images -q $(BASE_IMAGE_TAG) 2>/dev/null)
APP_PATH = $(REPO_DOMAIN)/$(REPO_OWNER)/$(REPO_NAME)
SED_SUFF = $(shell \[ \"$$(uname)\" = \"Darwin\" \] && echo ' ""' || echo \"\")

build/image:
	@docker build --build-arg APP_PATH=$(APP_PATH) . -t $(BASE_IMAGE_TAG)
 
build:
	@[ "$(DOCKER_IMAGE_RESULT)" = "" ] && make -s build/image || true

build/sh: build/image
	@docker run --name build-$(REPO_NAME) -ti \
		$(BASE_IMAGE_TAG) bash; \
		docker cp build-$(REPO_NAME):/go/src/$(APP_PATH) output/; \
		sed -i$(SED_SUFF) -e 's|$(APP_PATH)|{{DOCKER_APP_PATH}}|g' output/master/*go*; \
		mv output/master/go.* dir/; \
		docker rm build-$(REPO_NAME)

clean:
	@docker rmi $(BASE_IMAGE_TAG) || true

clone:
	rm -rf ../$(REPO_NAME) && cp -r repo ../$(REPO_NAME) && cd ../$(REPO_NAME) && \
		find . -type f -name "*.*" -print0 | xargs -0 sed -i$(SED_SUFF) \
			-e 's|{{MAKE_REPO_NAME}}|$(REPO_NAME)|g' \
			-e 's|{{MAKE_APP_PATH}}|$(APP_PATH)|g' \
			-e 's|{{MAKE_BASE_IMAGE_TAG}}|$(BASE_IMAGE_TAG)|g' && \
		git init && git add .
