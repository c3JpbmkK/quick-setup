#!/usr/bin/env bash

VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
EXECUTABLE_PATH="/bin/kubectl"

DOWNLOAD_DIR="/tmp/kubectl-${VERSION}"
mkdir -p "$DOWNLOAD_DIR" || echo "Error creating folder $DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

curl -sSL -LO "https://dl.k8s.io/release/${VERSION}/bin/linux/amd64/kubectl"
curl -sSL -LO "https://dl.k8s.io/${VERSION}/bin/linux/amd64/kubectl.sha256"

echo $(cat kubectl.sha256) kubectl | sha256sum -c
if [ $? -ne 0 ]
then
	echo "File integrity check failed. Cleaning up"
	rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
	exit 1
else
    chmod a+x kubectl
    cp kubectl $EXECUTABLE_PATH
    kubectl help &>/dev/null
    if [ $? -eq 0 ]
    then
        echo "Installed kubectl-$VERSION"
        rm -rf "$DOWNLOAD_DIR" || echo "Error deleting folder $DOWNLOAD_DIR"
    else
        echo "Error installing kubectl-${VERSION}"
        exit 1
    fi
fi
