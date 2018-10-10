#!/usr/bin/env bash

set -o pipefail
set -o nounset
set -o errexit
IFS=$'\n\t'

TEMPLATE_DIR=${TEMPLATE_DIR:-/tmp/arsenal}

################################################################################
### Packages ###################################################################
################################################################################

# Update the OS to begin with to catch up to the latest packages.
sudo yum update -y

# Install necessary packages
sudo yum install -y \
    aws-cfn-bootstrap \
    conntrack \
    curl \
    git \
    socat \
    unzip \
    wget

curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
sudo python get-pip.py
rm get-pip.py
sudo pip install --upgrade awscli

################################################################################
### Docker #####################################################################
################################################################################

sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo amazon-linux-extras enable docker
sudo yum install -y docker-17.06*
sudo usermod -aG docker $USER

# Clean up yum caches to reduce the image size
sudo yum clean all

# Enable docker daemon to start on boot.
sudo systemctl daemon-reload
sudo systemctl enable docker

################################################################################
### AWS Security Arsenal #######################################################
################################################################################
# get the latest list of tools from https://github.com/toniblyx/my-arsenal-of-aws-security-tools
# and clone them in to the /opt/arsenal directory
git clone https://github.com/toniblyx/my-arsenal-of-aws-security-tools
cd my-arsenal-of-aws-security-tools
# skipping RhinoSecurityLabs/pacu since it is not public yet and billing alerts CFN templates
TOOLS_URL_LIST=$(grep github.com README.md |awk -F '[' '{ print $2 }'| awk -F ']' '{ print $1 }' | grep -v pacu$|grep -v btkrausen)
sudo mkdir -p /opt/arsenal
cd /opt/arsenal
for tool_url in $TOOLS_URL_LIST; do
  sudo git clone $tool_url || \
    sudo git clone $tool_url $(basename $tool_url)-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1) || \
    :
done
