#!/usr/bin/env bash

set -eo pipefail

if [ -d /usr/local ]
then
	mkdir -p /usr/local
fi

for installer in $(ls -1 ./dnf/*.sh)
do
	echo "Using ${installer}"
	"${installer}"
done
