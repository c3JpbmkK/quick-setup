#!/usr/bin/env bash

VERSION="latest"
ARCH="x64"
DOWNLOAD_URL="https://code.visualstudio.com/sha/download?build=stable&os=linux-${ARCH}"
CODE_INSTALL_LOCATION="/usr/local/code"
EXECUTABLE_PATH="/bin/code"

DOWNLOAD_DIR="/tmp/code-${VERSION}"
mkdir -p $DOWNLOAD_DIR || echo "Error creating folder $DOWNLOAD_DIR"
cd $DOWNLOAD_DIR
curl -sSL -o code.tar.gz $DOWNLOAD_URL

mkdir -p $CODE_INSTALL_LOCATION || echo "Error creating folder $CODE_INSTALL_LOCATION"
tar -C $CODE_INSTALL_LOCATION -xvf code.tar.gz

if [ -f $EXECUTABLE_PATH ]
then
	echo "Removing exising symlink $EXECUTABLE_PATH"
	rm $EXECUTABLE_PATH
fi
ln -s $CODE_INSTALL_LOCATION/VSCode-linux-x64/bin/code $EXECUTABLE_PATH
sudo -u nobody code --version
if [ $? -eq 0 ]
then
	echo "Installed code-${VERSION}"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
else
	echo "Error installing code-${VERSION}"
	exit 1
fi
