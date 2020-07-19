default: build

include .env
export

IMAGE_NAMESPACE=catosplace
IMAGE_NAME=docker-docker-image-dojo

all: lint build analyse_layers

analyse_layers:
	@echo "Analysing ${IMAGE_NAME} layers..."
	@docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		wagoodman/dive:${DIVE_VERSION} \
		--ci ${IMAGE_NAMESPACE}/${IMAGE_NAME}
	@echo "Layer analysis completed!"

build:
	@echo "Building ${IMAGE_NAME} image..."
	@DOCKER_BUILDKIT=1 \
	docker build \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg DOJO_VERSION \
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
	@echo "Cleaning up Docker images..."
	@docker image prune -f
	@echo "Docker images cleaned!"

lint:
	@echo "Linting the ${IMAGE_NAME} image..."
	@docker run --rm -i \
		hadolint/hadolint:${HADOLINT_VERSION}-alpine \
		hadolint --ignore DL3018 - < Dockerfile
	@echo "${CONTAINER_NAME} linted successfully"

test:

.PHONY: all analyse_layers build checkmake clean default test