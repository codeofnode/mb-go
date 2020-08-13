# {{MAKE_REPO_NAME}}

# start development
```
make dev [EP=any_bin_or_command]
```
> Add EP=bash or any bin to start the container with different entrypoint


if container already exists
```
docker start --attach --interactive dev-{{MAKE_REPO_NAME}}
```

To cleanup disk space, run
```
docker rm dev-{{MAKE_REPO_NAME}}
```
