# Create an AMI with all security tools in the arsenal list

Configuration scripts for building a custom Amazon AMI with [HashiCorp Packer](https://www.packer.io/).

**NOT WORKING YET** 	
Still in development

## Setup

* You must have [Packer](https://www.packer.io/) installed on your local system.
For more information, see [Installing Packer](https://www.packer.io/docs/install/index.html)
in the Packer documentation.

* You must also have AWS account credentials configured so that Packer can make
calls to AWS API operations on your behalf. For more information, see [Authentication](https://www.packer.io/docs/builders/amazon.html#specifying-amazon-credentials)
in the Packer documentation.

**Note**

The default region used is to build this AMI is `us-east-1` and the instance
type is a `t2.medium` (4GB RAM, 2vCPUs, EBS only and $0.046400 hourly) and does
not qualify for the AWS free tier. You are charged for any instances created
when building this AMI. The base AMI used is `ami-b70554c8`, Amazon Linux 2.

## Building the AMI

A Makefile is provided to build the AMI, but it is just a small wrapper around
invoking Packer directly. You can initiate the build process by running the
following command in the root of this repository:

```bash
make
```

The Makefile runs Packer with the `my-aws-security-arsenal-packer-config.json`
build specification template and the [amazon-ebs](https://www.packer.io/docs/builders/amazon-ebs.html)
builder. An instance is launched and the Packer [Shell
Provisioner](https://www.packer.io/docs/provisioners/shell.html) runs the
`install-tools.sh` script on the instance to install software and perform other
necessary configuration tasks.  Then, Packer creates an AMI from the instance
and terminates the instance after the AMI is created.

## Using the AMI

If you are just getting started with security tools, visit [https://github.com/toniblyx/my-arsenal-of-aws-security-tools](https://github.com/toniblyx/my-arsenal-of-aws-security-tools)
and get familiar with every tool that you are interested in.

Launch an instance with the new AMI ID that is returned when Packer finishes building.

## Reference

Some code is taken as reference from here [https://github.com/awslabs/amazon-eks-ami](https://github.com/awslabs/amazon-eks-ami)
