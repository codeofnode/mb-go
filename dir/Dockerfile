FROM alpine:3.12

ARG REPO_NAME
ENV APP_EX=$REPO_NAME

RUN mkdir /workdir
WORKDIR /workdir
ADD executable ${REPO_NAME}

USER nobody:nobody

ENTRYPOINT /workdir/${APP_EX}
