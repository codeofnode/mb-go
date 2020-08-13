#!make

.PHONY: dev build build/image build/base build/base/image clean

include .sample.env
-include .env

MASTER_REPO := mb-go
REPO_NAME := $(shell basename $$(pwd))
BASE_IMAGE_TAG = $(REPO_REG)$(REPO_OWNER)/base-$(REPO_NAME):$(BASE_REPO_VERSION)
IMAGE_TAG = $(REPO_REG)$(REPO_OWNER)/$(REPO_NAME):$(REPO_VERSION)
DOCKER_IMAGE_RESULT = $(shell docker images -q $(BASE_IMAGE_TAG) 2>/dev/null)
APP_PATH = $(REPO_DOMAIN)/$(REPO_OWNER)/$(REPO_NAME)
SED_SUFF = $(shell \[ \"$$(uname)\" = \"Darwin\" \] && echo ' ""' || echo \"\")

build/base/image:
	@cd ..; [ ! -d $(MASTER_REPO) ] && git clone git@$(REPO_DOMAIN):$(REPO_OWNER)/$(MASTER_REPO).git; \
		cd $(MASTER_REPO) && git checkout $(REPO_NAME) && make build
 
build/base:
	@[ "$(DOCKER_IMAGE_RESULT)" = "" ] && make -s build/base/image || true

build: build/base
	@mkdir -p output && make -s dev EP="make build" && make -s build/image
 
dev:
	@docker run --name dev-$(REPO_NAME) -ti \
		-v `pwd`/output:/go/src/$(APP_PATH)/output \
		-v `pwd`/pkg:/go/src/$(APP_PATH)/pkg \
		-v `pwd`/configs:/go/src/{{MAKE_APP_PATH}}/configs \
		$(BASE_IMAGE_TAG) $(EP)

build/image:
	@cd output; docker build --build-arg REPO_NAME=$(REPO_NAME) . -t $(IMAGE_TAG)

clean:
	@docker rmi $(IMAGE_TAG) || true
