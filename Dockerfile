FROM golang:rc-buster
ENV GO111MODULE on
ARG APP_PATH
COPY dir /go/src/${APP_PATH}
COPY root /
RUN apt update && \
  apt install -y inotify-tools && \
  chmod +x /entrypoint.sh && \
  sed -i -e 's|{{DOCKER_REPLACE_APP_PATH}}|'${APP_PATH}'|' /go/src/${APP_PATH}/go.mod
ENTRYPOINT ["/entrypoint.sh"]
CMD ["make"]
