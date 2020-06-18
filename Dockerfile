FROM golang:rc-buster
ENV GO111MODULE on
ARG APP_PATH
ARG REPO_DOMAIN
ARG REPO_OWNER
COPY dir /go/src/${APP_PATH}
COPY godev /go/src/${REPO_DOMAIN}/${REPO_OWNER}/godev
COPY root /
WORKDIR /go/src/${APP_PATH}
RUN apt update && \
	apt install -y inotify-tools && \
	chmod +x /entrypoint.sh && \
	find . -type f -name "*.*" -print0 | xargs -0 sed -i \
		-e 's|{{DOCKER_APP_PATH}}|'${APP_PATH}'|g' && \
	go mod download && \
	cp main.go ../godev/ && \
	cd ../godev && \
	find . -type f -name "*.*" -print0 | xargs -0 sed -i \
		-e 's|{{DOCKER_APP_PATH}}|'${REPO_DOMAIN}'/'${REPO_OWNER}'/godev|g' && \
	go mod download
ENTRYPOINT ["/entrypoint.sh"]
CMD ["make", "dev"]
