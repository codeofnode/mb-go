FROM golang:rc-buster
ENV GO111MODULE on
RUN apt update && \
  apt install -y inotify-tools
