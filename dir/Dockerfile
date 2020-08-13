FROM alpine:3.12

ARG REPO_NAME
ENV APP_EX=$REPO_NAME
ADD executable /usr/bin/${REPO_NAME}

RUN mkdir /REPO_NAME

USER nobody:nobody

ENTRYPOINT ["${APP_EX}"]
