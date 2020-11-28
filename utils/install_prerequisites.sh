#!/bin/bash

# Import .env variables
read -ra args < <(grep -E -v '^#' ../.env | xargs)
export "${args[@]}"

# Install Docker
RUN set -eux; \
    sudo systemctl stop docker; \
    sudo systemctl stop containerd; \
  	if ! wget -O docker.tgz "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz"; then \
		echo >&2 "error: failed to download 'docker-${DOCKER_VERSION}' from stable for x86_64"; \
		exit 1; \
	fi; \
  	\
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
        --overwrite \
		--directory /usr/bin/ \
	; \
	rm docker.tgz; \
	\
    sudo systemctl start docker; \
    sudo systemctl start containerd; \
	dockerd --version; \
	docker --version

# Install Dojo
wget -O /tmp/dojo https://github.com/kudulab/dojo/releases/download/"${DOJO_VERSION}"/dojo_linux_amd64
chmod +x /tmp/dojo
sudo mv /tmp/dojo /usr/local/bin/dojo

# Install pre-commit
curl https://pre-commit.com/install-local.py | python3 -
# shellcheck source=/dev/null
source ~/.profile