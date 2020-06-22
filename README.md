# mb-go
> A solution to the problem of code duplication when dealing with large number of repositories.

# solution to the problems
* Messed up management of common code.
* Very large build time of because of common lib
* Vulnerability fixes in common code
* Change version of common lib used
* How to enforce compliances, or security checks?
* How to smoothly use licencing of various common lib?

# usage
### build the base image
```
make build
```

### clone a new repo out of current branch
```
make clone
```
this will create new directory `sandbox`, you may move this new dir to any other dir in your workspace.
There will be some min code to start with and you may place your buisness logic as packages in `pkg`.

# heirarchy
Every branch in this repo is factory for building base docker image for specific purpose.
Master branch is root of all base images.
Rest of branches like current one, adds new liberaries / dependencies on top of its super branch (base image)

## super branch
> master

## liberaries added
* server / mux router
* endpoint generator using config/swagger.yaml

## TODO
* better documentation
