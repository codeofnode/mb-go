# {{MAKE_REPO_NAME}}

# start development
```
docker run --name dev-{{MAKE_REPO_NAME}} -ti \
  --volume `pwd`/output:/go/src/{{MAKE_APP_PATH}}/output \
  --volume `pwd`/pkg:/go/src/{{MAKE_APP_PATH}}/pkg \
  --volume `pwd`/main.go:/go/src/{{MAKE_APP_PATH}}/main.go \
  {{MAKE_BASE_IMAGE_TAG}} dev
```
> Replace above `dev` with `bash` or any bin to start the container with different entrypoint


if container already exists
```
docker start --attach --interactive dev-{{MAKE_REPO_NAME}}
```

To cleanup disk space, run
```
docker rm dev-{{MAKE_REPO_NAME}}
```
