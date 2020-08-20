# Docker Image Development Dojo Project

This is a development environment for Docker images built using [Dojo](https://github.com/kudulab/dojo).

This image enables you to lint your Docker images.

## Usage

1. Install [Docker](https://docs.docker.com/install/), if you do not have it already.
2. Install [Dojo](https://github.com/ai-traders/dojo), it is a self-containted binary, so just place it somewhere on the `PATH`. On OSX you can use `brew install kudulab/homebrew-dojo-osx/dojo`.

**On Linux**
```bash
DOJO_VERSION=0.9.0
wget -O dojo https://github.com/kudulab/dojo/releases/download/${DOJO_VERSION}/dojo_linux_amd64
sudo mv dojo /usr/local/bin
sudo chmod +x /usr/local/bin/dojo
```

3. Checkout and `cd` into a project with a Docker image, then start the Dojo container
```bash
git clone https://github.com/catosplace/docker-docker-image-dojo
cd docker-docker-image-dojo
dojo
```

This will enter the Dojo Docker container with all the tools needed to lint your Docker image. Your local code is available in the current directory `/dojo/work`.

## Tools
This Dojo image provides the following tools for use when building Docker images

* [Hadolint](https://github.com/hadolint/hadolint)
* [Shellcheck](https://github.com/koalaman/shellcheck)

### Hadolint

```
$ hadolint Dockerfile
```

### Shellcheck

```
$ shellcheck test.sh
```

## Development

**Dependencies**
* Docker
* Dojo
* [catosplace/docker-bats-core-dojo](https://github.com/catosplace/docker-bats-core-dojo) Docker image


```
export DOCKER_BUILDKIT=1
docker build \
  --build-arg ALPINE_VERSION=<ALPINE_VERSION> \
  -t catosplace/docker-docker-image-dojo .
```

```
make
```

**Pre-Commit**

`pre-commit install`

`pre-commit run --all-files`


### TO-DO
Update Development Documentation
Add License
Fix up the Structure of the Project
Add MicroBadger / ImageLayers.io
Decide on CI/CD - Circle CI?
Add ADRS?

Tools
* dive
* skopeo (inspection)
* conftest (docker-security-check)