default: build

include .env
export

IMAGE_NAMESPACE=catosplace
IMAGE_NAME=docker-docker-image-dojo

bash_scripts= "./image/bashrc" "./image/profile" \
	"./image/entrypoint.sh" \
	"./image/etc_dojo.d/scripts/20-setup-identity.sh" \
	"./image/etc_dojo.d/scripts/80-docker-socket.sh" \
	"./utils/install_prerequisites.sh" \
	"./utils/generate_test_dojofile.sh" \
	"./test/integration/end_user/bats/01_dojo.bats" \
	"./test/integration/end_user/bats/05_docker.bats" \
	"./test/integration/end_user/bats/10_adrtools.bats" \
	"./test/integration/end_user/bats/15_bats.bats" \
	"./test/integration/end_user/bats/20_hadolint.bats" \
	"./test/integration/end_user/bats/21_shellcheck.bats" 

all: lint build test analyse_layers

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
	docker build --no-cache \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg ADR_TOOLS_VERSION=${ADR_TOOLS_VERSION} \
		--build-arg BATS_VERSION \
		--build-arg DOCKER_VERSION \
		--build-arg DOJO_VERSION \
		--build-arg GOSS_VERSION \
		--build-arg HADOLINT_VERSION \
		--build-arg SHELLCHECK_VERSION \
		-t catosplace/docker-docker-image-dojo ./image
	@echo "${IMAGE_NAME} container built!"
	@docker images catosplace/docker-docker-image-dojo
	@echo ""

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

lint_all: lint lint_bash

lint:
	@echo "Linting the ${IMAGE_NAME} image..."
	@hadolint --ignore DL3018 ./image/Dockerfile
	@echo "${IMAGE_NAME} linted successfully!"

lint_bash: ${bash_scripts}

# Note the use of the -x flag to shellcheck enabling
# it to follow other files
${bash_scripts}:
	@echo "Linting the $@ bash script..."
	@shellcheck -x $@
	@echo "$@ linted successfully!"

test:
	@echo "Testing the Dojo image..."
	@bats test/integration/end_user/bats
	@echo "Tested the Dojo image!"

.PHONY: all clean test default