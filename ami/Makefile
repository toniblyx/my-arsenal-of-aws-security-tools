KUBERNETES_VERSION ?= 1.10.3

DATE ?= $(shell date +%Y-%m-%d)

# Defaults to Amazon Linux 2  AMI
# * use the us-east-1 image
# https://aws.amazon.com/amazon-linux-2/release-notes/
SOURCE_AMI_ID ?= ami-b70554c8

AWS_DEFAULT_REGION = us-east-1

PACKER_CONFIG_FILE = my-aws-security-arsenal-packer-config.json

all: ami

validate:
	packer validate $(PACKER_CONFIG_FILE)

ami: validate
	packer build -var source_ami_id=$(SOURCE_AMI_ID) $(PACKER_CONFIG_FILE)
