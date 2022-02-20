#!/usr/bin/env bash

set -e

if [ -d /usr/local ]
then
	mkdir -p /usr/local
fi

for installer in $(ls -1 ./scripts/*.sh)
do
	echo "Using ${installer}"
	./scripts/"${installer}"
done
