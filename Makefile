default: build

include .env
export

IMAGE_NAME=docker-docker-image-dojo

all: lint build

build:
	@echo "Building ${CONTAINER_NAME} image..."
	@DOCKER_BUILDKIT=1 \
	docker build \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		-t catosplace/docker-docker-image-dojo .
	@echo "docker-docker-image-dojo container built!"
	@docker images catosplace/docker-docker-image-dojo

checkmake:
	@echo "Linking the Makfile..."
	@docker run --rm \
		-v ${PWD}:/data \
		cytopia/checkmake:${CHECKMAKE_VERSION} Makefile
	@echo "Makefile linting successful!"

clean:

lint:
	@echo "Linting the ${CONTAINER_NAME} image..."
	@docker run --rm -i \
		hadolint/hadolint:${HADOLINT_VERSION}-alpine \
		< Dockerfile
	@echo "${CONTAINER_NAME} linted successfully"

test:

.PHONY: all build checkmake clean default test