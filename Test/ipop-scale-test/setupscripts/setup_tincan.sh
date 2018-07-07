#!/bin/bash

if [ -e $TINCAN ]; then
	echo "Using existing Tincan binary..."
else
	if ! [ -e "./Tincan/trunk/build/" ]; then
		if [ -z "$DEFAULT_TINCAN_REPO" ]; then
			echo -e "\e[1;31mEnter github URL for Tincan\e[0m"
			read DEFAULT_TINCAN_REPO
			if [ -z "$DEFAULT_TINCAN_REPO" ] ; then
				error "A Tincan repo URL is required"
			fi
		fi
		git clone $DEFAULT_TINCAN_REPO Tincan
		if [ -z $DEFAULT_TINCAN_BRANCH ]; then
			echo -e "Enter git repo branch name:"
			read DEFAULT_TINCAN_BRANCH
		fi
		cd Tincan
		git checkout $DEFAULT_TINCAN_BRANCH
	cd ..
	fi

	# Set up 3rd party dependencies for Ubuntu
	cd ./Tincan/external
	if [ -z "$DEFAULT_3RD_PARTY_REPO" ]; then
		echo -e "\e[1;31mEnter github URL for 3rd party Tincan dependencies\e[0m"
		read DEFAULT_3RD_PARTY_REPO
		if [ -z "$DEFAULT_3RD_PARTY_REPO" ] ; then
			error "A 3rd party dependencies repo URL is required"
		fi
	fi
	if [ -z $DEFAULT_3RD_PARTY_BRANCH ]; then
		echo -e "Enter 3rd party dependencies repo branch name:"
		read DEFAULT_3RD_PARTY_BRANCH
	fi
	git clone -b $DEFAULT_3RD_PARTY_BRANCH --single-branch $DEFAULT_3RD_PARTY_REPO

	cd ../trunk/build/
	echo "Building Tincan binary"
	make
	cd ../../..
	cp ./Tincan/trunk/out/release/x86_64/ipop-tincan .
fi
