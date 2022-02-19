#!/usr/bin/env bash

for installer in $(ls -1 ./scripts)
do
	echo "Using ${installer}"
	./scripts/"${installer}"
done
