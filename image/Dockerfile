ARG ALPINE_VERSION

FROM alpine:${ALPINE_VERSION}

ARG DOJO_VERSION
ARG HADOLINT_VERSION

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

#TODO: Add the tools the project needs

RUN wget -O /tmp/hadolint https://github.com/hadolint/hadolint/releases/download/${HADOLINT_VERSION}/hadolint-Linux-x86_64 \
  && chmod +x /tmp/hadolint \
  && mv /tmp/hadolint /usr/local/bin/hadolint

# Optional scripts to run on container start
COPY etc_dojo.d/scripts/* /etc/dojo.d/scripts/

# Optional environment variables to source on container start
#COPY etc/dojo.d/variables/* /etc/dojo.d/variables

COPY profile /home/dojo/.profile
COPY bashrc /home/dojo/.bashrc
RUN chown dojo:dojo /home/dojo/.profile /home/dojo/.bashrc

ENTRYPOINT ["/sbin/tini", "-g", "--", "/usr/bin/entrypoint.sh"]
CMD ["/bin/bash"]