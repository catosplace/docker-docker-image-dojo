# Docker Image Dojo Project

```
export DOCKER_BUILDKIT=1
docker build \
  --build-arg ALPINE_VERSION=<ALPINE_VERSION> \
  -t catosplace/docker-docker-image-dojo .
```

```
make
```

Need
* Docker
* Dojo


### TO-DO
Iterate over list of files - and do shellcheck
Bash Linting - profile and 20-setup-identity.sh
Add MicroBadger / ImageLayers.io