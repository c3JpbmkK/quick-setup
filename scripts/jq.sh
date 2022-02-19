#!/usr/bin/env bash

VERSION="1.6"
ARCH="64"
RELEASES="https://github.com/stedolan/jq/releases"
DOWNLOAD_URL="${RELEASES}/download/jq-${VERSION}/jq-linux${ARCH}"
EXECUTABLE_PATH="/bin/jq"

echo "Downloading jq binary"
curl -sSL -o "$EXECUTABLE_PATH" "$DOWNLOAD_URL" 
chmod a+x "$EXECUTABLE_PATH" 

jq --version
if [ $? -eq 0 ]
then
	echo "Installed jq-$VERSION"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
else
	echo "Error installing jq-${VERSION}"
	exit 1
fi

