#!/usr/bin/env bash

RELEASES="https://github.com/helm/helm/releases"
VERSION="v3.8.0"
ARCH="amd64"
DOWNLOAD_URL="https://get.helm.sh/helm-${VERSION}-linux-${ARCH}.tar.gz"
CHECKSUM_URL="https://get.helm.sh/helm-${VERSION}-linux-${ARCH}.tar.gz.sha256sum"
EXECUTABLE_PATH="/bin/helm"

DOWNLOAD_DIR="/tmp/helm-${VERSION}"
mkdir -p "$DOWNLOAD_DIR" || echo "Error creating folder $DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

curl -sSL -O "$DOWNLOAD_URL"
curl -sSL -O "$CHECKSUM_URL"

sha256sum -c helm-${VERSION}-linux-${ARCH}.tar.gz.sha256sum
if [ $? -ne 0 ]
then
	echo "File integrity check failed. Cleaning up"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
	exit 1
fi

tar -xvf helm-${VERSION}-linux-${ARCH}.tar.gz
cd linux-${ARCH}
chmod a+x helm
if [ -f $EXECUTABLE_PATH ]
then
	echo "Removing exising symlink $EXECUTABLE_PATH"
	rm $EXECUTABLE_PATH
fi

cp helm $EXECUTABLE_PATH
helm version
if [ $? -eq 0 ]
then
	echo "Installed helm-${VERSION}"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
else
	echo "Error installing helm-${VERSION}"
	exit 1
fi


