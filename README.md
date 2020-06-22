# mb-go
> A solution to the problem of code duplication when dealing with large number of repositories.

# heirarchy
Every branch in this repo is factory for building base docker image for specific purpose.
Master branch is root of all base images.
Rest of branches like `server` adds new liberaries / dependencies on top of its super branch (base image)

# solution to the problems
* Messed up management of common code.
* Very large build time of because of common lib
* Vulnerability fixes in common code
* Change version of common lib used
* How to enforce compliances, or security checks?
* How to smoothly use licencing of various common lib?

# usage
Please switch to any branch eg `server`. to see corresponding usage
