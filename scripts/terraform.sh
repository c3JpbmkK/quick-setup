#!/usr/bin/env bash

VERSION="1.1.6"
ARCH="amd64"
TF_DOWNLOAD_URL="https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_${ARCH}.zip"
EXECUTABLE_PATH="/bin/terraform"

rm /bin/terraform || echo "No previous version of Terraform binary found"

DOWNLOAD_DIR="/tmp/tf-${VERSION}"
mkdir -p $DOWNLOAD_DIR || echo "Error creating folder $DOWNLOAD_DIR"
cd $DOWNLOAD_DIR

curl -sSL -O "$TF_DOWNLOAD_URL"
unzip terraform_${VERSION}_linux_${ARCH}.zip
chmod a+x terraform
mv ./terraform /bin/terraform

terraform version
if [ $? -eq 0 ]
then
	echo "Installed go-${VERSION}"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
else
	echo "Error installing go-${VERSION}"
	exit 1
fi

