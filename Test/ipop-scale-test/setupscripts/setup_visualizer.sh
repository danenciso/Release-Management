#!/bin/bash

if ! [ -z $1 ]; then
	visualizer_repo=$1
else
	visualizer_repo=$DEFAULT_VISUALIZER_REPO
fi
if ! [ -z $2 ]; then
	visualizer_branch=$2
else
	visualizer_branch=$DEFAULT_VISUALIZER_BRANCH
fi

if ! [ -e $VISUALIZER ]; then
	if [ -z "$visualizer_repo" ]; then
		echo -e "\e[1;31mEnter visualizer github URL\e[0m"
		read visualizer_repo
	fi
	git clone $visualizer_repo
	if [ -z "$visualizer_branch" ]; then
		echo -e "Enter git repo branch name:"
		read visualizer_branch
	fi
	cd $VISUALIZER
	git checkout $visualizer_branch
	# Use visualizer setup script
	cd setup && ./setup.sh && cd ../..
fi
