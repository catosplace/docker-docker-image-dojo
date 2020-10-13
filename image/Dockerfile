ARG ALPINE_VERSION

FROM alpine:${ALPINE_VERSION}

ARG BATS_VERSION
ARG DOJO_VERSION
ARG GOSS_VERSION
ARG HADOLINT_VERSION
ARG SHELLCHECK_VERSION

############
# Install Common Dojo Scripts
# For Dojo:
# * entrypoint requires sudo and shadow
# * git is needed to install dojo image configs
ENV DOJO_VERSION=${DOJO_VERSION}
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache tini bash shadow sudo git && \
  git clone --depth 1 -b ${DOJO_VERSION} https://github.com/kudulab/dojo.git /tmp/dojo_git && \
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git
############

# Docker Installation (Package - Needs to be a version)
ENV DOCKER_VERSION 19.03.13
RUN set -eux; \
  	if ! wget -O docker.tgz "https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz"; then \
		echo >&2 "error: failed to download 'docker-${DOCKER_VERSION}' from stable for x86_64"; \
		exit 1; \
	fi; \
  	\
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	rm docker.tgz; \
	\
	dockerd --version; \
	docker --version
# RUN apk add --no-cache docker

#TODO: Add the tools the project needs

# Make
RUN apk add --no-cache make

# Hadolint - https://github.com/hadolint/hadolint
RUN wget -O /tmp/hadolint https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64 \
  && chmod +x /tmp/hadolint \
  && mv /tmp/hadolint /usr/local/bin/hadolint

# Shellcheck - https://github.com/koalaman/shellcheck
RUN wget -O /tmp/shellcheck.tar.xz https://github.com/koalaman/shellcheck/releases/download/${SHELLCHECK_VERSION}/shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz \
  && tar -xvf /tmp/shellcheck.tar.xz -C /tmp \
  && chmod +x /tmp/shellcheck-${SHELLCHECK_VERSION}/shellcheck \
  && mv /tmp/shellcheck-${SHELLCHECK_VERSION}/shellcheck /usr/local/bin/shellcheck

COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

# Optional scripts to run on container start
COPY etc_dojo.d/scripts/* /etc/dojo.d/scripts/

# Optional environment variables to source on container start
# COPY etc_dojo.d/variables/* /etc/dojo.d/variables/

COPY profile /home/dojo/.profile
COPY bashrc /home/dojo/.bashrc
RUN chown dojo:dojo /home/dojo/.profile /home/dojo/.bashrc

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]