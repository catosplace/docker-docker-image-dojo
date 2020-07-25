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

Pre-Commit

`pre-commit install`

`pre-commit run --all-files`


### TO-DO
Use .env in util Bash script + Add Docker (Optional/Version)
Add dgoss tests
Add MicroBadger / ImageLayers.io
Decide on CI/CD - Concourse
Improve Documentation

Tools
* hadolint
* shellcheck
* dive
* checkmake
* dgoss
* skopeo (inspection)
* conftest (docker-security-check)