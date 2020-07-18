Docker Image Dojo Project

```
export DOCKER_BUILDKIT=1
docker build \
  --build-arg ALPINE_VERSION=<ALPINE_VERSION> \
  -t catosplace/docker-docker-image-dojo .
```

```
make
```