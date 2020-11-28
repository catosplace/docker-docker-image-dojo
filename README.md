# Docker Image Development Dojo Project

This is a development environment for Docker images built using [Dojo](https://github.com/kudulab/dojo).

This image enables you to build,lint and test your Docker images.

## Specification
This image has installed:

* bats
* checkmake
* dive
* docker `19.03.13`
* dojo `0.10.2`
* hadolint
* shellcheck

## Usage

1. Install [Docker](https://docs.docker.com/install/), if you do not have it already.
2. Install [Dojo](https://github.com/kudulab/dojo), it is a self-containted binary, so just place it somewhere on the `PATH`. On OSX you can use `brew install kudulab/homebrew-dojo-osx/dojo`.

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

This will enter the Dojo Docker container with all the tools needed to build, lint and test your Docker image. Your local code is available in the current directory `/dojo/work`.

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

## License

MIT License

Copyright (c) 2020 Catosplace

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


### TO-DO
* Update Development Documentation
* Add License
* Fix up the Structure of the Project
* Add MicroBadger / ImageLayers.io
* Decide on CI/CD - Circle CI?
* Add ADRS?

Tools
* dive
* skopeo (inspection)
* conftest (docker-security-check)