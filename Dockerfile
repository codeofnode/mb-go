FROM golang:rc-buster
ENV GO111MODULE on
ARG APP_PATH
COPY dir /go/src/${APP_PATH}
COPY root /
WORKDIR /go/src/${APP_PATH}
RUN apt update && \
  apt install -y inotify-tools && \
  chmod +x /entrypoint.sh && \
	find . -type f -name "*.*" -print0 | xargs -0 sed -i \
		-e 's|{{DOCKER_APP_PATH}}|'${APP_PATH}'|g'
ENTRYPOINT ["/entrypoint.sh"]
CMD ["make", "dev"]
