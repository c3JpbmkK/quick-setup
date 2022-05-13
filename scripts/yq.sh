#!/usr/bin/env bash

VERSION="v4.25.1"
ARCH="amd64"
RELEASES="https://github.com/mikefarah/yq/releases"
DOWNLOAD_URL="${RELEASES}/download/${VERSION}/yq_linux_${ARCH}"
EXECUTABLE_PATH="/bin/yq"

echo "Downloading yq binary"
curl -sSL -o "$EXECUTABLE_PATH" "$DOWNLOAD_URL" 
chmod a+x "$EXECUTABLE_PATH" 

yq --version
if [ $? -eq 0 ]
then
	echo "Installed yq-$VERSION"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
else
	echo "Error installing yq-${VERSION}"
	exit 1
fi
