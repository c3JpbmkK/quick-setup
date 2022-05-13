#!/usr/bin/env bash

# This may not work always 
# Especially on systems without yum or dnf

if which dnf 2>/dev/null
then
	dnf install -y ansible sshpass
elif which yum 2>/dev/null
then
	yum install -y ansible sshpass
elif which pip3 2>/dev/null
then
	pip3 install ansible
fi

ansible --version
if [ $? -eq 0 ]
then
	echo "Installed Ansible successfully"
else
	echo "Ansible installation failed"
	exit 1
fi
