# {{MAKE_REPO_NAME}}

# start development
```
docker run --name dev-{{MAKE_REPO_NAME}} -ti \
  -v `pwd`/output:/go/src/{{MAKE_APP_PATH}}/output \
  -v `pwd`/pkg:/go/src/{{MAKE_APP_PATH}}/pkg \
  -v `pwd`/main.go:/go/src/{{MAKE_APP_PATH}}/main.go \
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
