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
Add initial tool - hadolint and test dojo container
Add dgoss tests
Add MicroBadger / ImageLayers.io
Decide on CI/CD - Concourse
Inception - use Docker Pre-Commits using Dojo Container!

Tools
* hadolint
* shellcheck
* dive
* checkmake
* dgoss
* skopeo (inspection)
* conftest (docker-security-check)