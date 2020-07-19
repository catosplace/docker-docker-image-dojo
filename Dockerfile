ARG ALPINE_VERSION

FROM alpine:${ALPINE_VERSION}

ARG DOJO_VERSION

# Install common Dojo scripts
ENV DOJO_VERSION=${DOJO_VERSION}
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache tini bash shadow sudo git && \
  git clone --depth 1 -b ${DOJO_VERSION} https://github.com/kudulab/dojo.git /tmp/dojo_git && \
  /tmp/dojo_git/image_scripts/src/install.sh && \
  rm -r /tmp/dojo_git

#TODO: Add the tools the project needs