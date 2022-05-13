#!/usr/bin/env bash

RELEASES="https://github.com/htop-dev/htop/releases"
VERSION="3.1.2"
DOWNLOAD_URL="https://github.com/htop-dev/htop/releases/download/${VERSION}/htop-${VERSION}.tar.xz"
CHECKSUM_URL="https://github.com/htop-dev/htop/releases/download/${VERSION}/htop-${VERSION}.tar.xz.sha256"

DOWNLOAD_DIR="/tmp/htop-${VERSION}"
mkdir -p "$DOWNLOAD_DIR" || echo "Error creating folder $DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

curl -sSL -O "$DOWNLOAD_URL"
curl -sSL -O "$CHECKSUM_URL"

sha256sum -c htop-${VERSION}.tar.xz.sha256
if [ $? -ne 0 ]
then
	echo "File integrity check failed. Cleaning up"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
	exit 1
fi

tar -xvf htop-${VERSION}.tar.xz
cd htop-${VERSION}
./configure
make && make install

htop --version
if [ $? -eq 0 ]
then
	echo "Installed htop-${VERSION}"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
else
	echo "Error installing htop-${VERSION}"
	exit 1
fi
