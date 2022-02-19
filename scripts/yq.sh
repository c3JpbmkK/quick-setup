#!/usr/bin/env bash

RELEASES="https://github.com/htop-dev/htop/releases"

VERSION="v4.20.1"
BINARY="yq_linux_amd64"
DOWNLOAD_URL="https://github.com/mikefarah/yq/releases/download/${VERSION}/${BINARY}"
YQ_BIN="/bin/yq"

echo "Downloading yq binary"
curl -sSL -o "$YQ_BIN" "$DOWNLOAD_URL" 
chmod a+x "$YQ_BIN" 

yq --version
if [ $? -eq 0 ]
then
	echo "Installed yq-$VERSION"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
else
	echo "Error installing yq-${VERSION}"
fi

