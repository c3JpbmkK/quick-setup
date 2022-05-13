#!/usr/bin/env bash

VERSION="1.17.7"
GO_DOWNLOAD_URL="https://go.dev/dl/go${VERSION}.linux-amd64.tar.gz"
GO_INSTALL_LOCATION="/usr/local/go"
EXECUTABLE_PATH="/bin/go"

DOWNLOAD_DIR="/tmp/go-${VERSION}"
mkdir -p $DOWNLOAD_DIR || echo "Error creating folder $DOWNLOAD_DIR"
cd $DOWNLOAD_DIR

curl -sSL -O "$GO_DOWNLOAD_URL"
mkdir -p $GO_INSTALL_LOCATION || echo "Error creating folder $GO_INSTALL_LOCATION"
tar -C $GO_INSTALL_LOCATION -xvf go${VERSION}.linux-amd64.tar.gz

if [ -f $EXECUTABLE_PATH ]
then
	echo "Removing exising symlink $EXECUTABLE_PATH"
	rm $EXECUTABLE_PATH
fi
ln -s $GO_INSTALL_LOCATION/go/bin/go $EXECUTABLE_PATH
go version
if [ $? -eq 0 ]
then
	echo "Installed go-${VERSION}"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
else
	echo "Error installing go-${VERSION}"
	exit 1
fi
