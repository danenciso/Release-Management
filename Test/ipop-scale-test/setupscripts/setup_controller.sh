#!/bin/bash

if ! [ -e $CONTROLLER ]; then
	if [ -z "$DEFAULT_CONTROLLERS_REPO" ]; then
		echo -e "\e[1;31mEnter IPOP Controller github URL\e[0m"
		read DEFAULT_CONTROLLERS_REPO
		if [ -z "$DEFAULT_CONTROLLERS_REPO" ]; then
			error "A controller repo URL is required"
		fi
	fi
	git clone $DEFAULT_CONTROLLERS_REPO
	if [ -z $DEFAULT_CONTROLLERS_BRANCH ]; then
		echo -e "Enter git repo branch name:"
		read DEFAULT_CONTROLLERS_BRANCH
	fi
	cd Controllers
	git checkout $DEFAULT_CONTROLLERS_BRANCH
	cd ..
else
	echo "Using existing Controller repo..."
fi
