default: build

include .env
export

IMAGE_NAMESPACE=catosplace
IMAGE_NAME=docker-docker-image-dojo

bash_scripts= "./image/bashrc" "./image/profile" \
	"./image/etc_dojo.d/scripts/20-setup-identity.sh" \
	"./utils/install_prerequisites.sh"

all: lint build analyse_layers

analyse_layers:
	@echo "Analysing ${IMAGE_NAME} layers..."
	@docker run --rm -it \
		-v /var/run/docker.sock:/var/run/docker.sock \
		wagoodman/dive:${DIVE_VERSION} \
		--ci ${IMAGE_NAMESPACE}/${IMAGE_NAME}
	@echo "Layer analysis completed!\n"

build:
	@echo "Building ${IMAGE_NAME} image..."
	@DOCKER_BUILDKIT=1 \
	docker build \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg BATS_VERSION \
		--build-arg DOJO_VERSION \
		--build-arg GOSS_VERSION \
		--build-arg HADOLINT_VERSION \
		--build-arg SHELLCHECK_VERSION \
		-t catosplace/docker-docker-image-dojo ./image/.
	@echo "${IMAGE_NAME} container built!\n"
	@docker images catosplace/docker-docker-image-dojo
	@echo ""

checkmake:
	@echo "Linking the Makfile..."
	@docker run --rm \
		-v ${PWD}:/data \
		cytopia/checkmake:${CHECKMAKE_VERSION} Makefile
	@echo "Makefile linting successful!\n"

clean:
	@echo "Cleaning up Docker images..."
	@docker image prune -f
	@echo "Docker images cleaned!\n"

lint:
	@echo "Linting the ${IMAGE_NAME} image..."
	@dojo "hadolint --ignore DL3018 ./image/Dockerfile"
	@echo "${IMAGE_NAME} linted successfully!\n"

lint_bash: ${bash_scripts}

# Note the use of the -x flag to shellcheck enabling
# it to follow other files
${bash_scripts}:
	@echo "Linting the $@ bash script..."
	@dojo "shellcheck -x $@"
	@echo "$@ linted successfully!\n"

test:

.PHONY: all clean test default