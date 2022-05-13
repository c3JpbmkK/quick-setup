#!/usr/bin/env bash

set -eo pipefail

mkdir -p /usr/local
for installer in $(ls -1 ./dnf/*.sh)
do
	echo "Using ${installer}"
	"${installer}"
done
