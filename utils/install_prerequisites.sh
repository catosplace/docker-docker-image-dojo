#!/bin/bash

# TODO - Pick this up from the .env file
DOJO_VERSION=0.8.0

# Install Dojo
wget -O /tmp/dojo https://github.com/kudulab/dojo/releases/download/${DOJO_VERSION}/dojo_linux_amd64
chmod +x /tmp/dojo
sudo mv /tmp/dojo /usr/local/bin/dojo

# Install pre-commit
curl https://pre-commit.com/install-local.py | python3 -
# shellcheck source=/dev/null
source ~/.profile