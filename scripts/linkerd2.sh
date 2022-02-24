#!/usr/bin/env bash

RELEASES="https://github.com/linkerd/linkerd2/releases"
VERSION="edge-22.2.3"
ARCH="amd64"
DOWNLOAD_URL="https://github.com/linkerd/linkerd2/releases/download/${VERSION}/linkerd2-cli-${VERSION}-linux-${ARCH}"
CHECKSUM_URL="https://github.com/linkerd/linkerd2/releases/download/${VERSION}/linkerd2-cli-${VERSION}-linux-${ARCH}.sha256"
EXECUTABLE_PATH="/bin/linkerd"

DOWNLOAD_DIR="/tmp/linkerd-${VERSION}"
mkdir -p "$DOWNLOAD_DIR" || echo "Error creating folder $DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

curl -sSL -O "$DOWNLOAD_URL"
curl -sSL -O "$CHECKSUM_URL"

if [ "$(sha256sum linkerd2-cli-${VERSION}-linux-${ARCH} | sed "s/ .*//")" != "$(cat linkerd2-cli-${VERSION}-linux-${ARCH}.sha256)" ]
then
	echo "File integrity check failed. Cleaning up"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
	exit 1
fi

chmod a+x linkerd2-cli-${VERSION}-linux-${ARCH}
if [ -f $EXECUTABLE_PATH ]
then
	echo "Removing exising symlink $EXECUTABLE_PATH"
	rm $EXECUTABLE_PATH
fi

cp linkerd2-cli-${VERSION}-linux-${ARCH} $EXECUTABLE_PATH
linkerd version --client
if [ $? -eq 0 ]
then
	echo "Installed linkerd-${VERSION}"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
else
	echo "Error installing linkerd-${VERSION}"
	exit 1
fi


