#!/bin/bash

if [ $VPNMODE = "classic" ]; then
	for i in $(seq $min $max); do
		mkdir -p logs/"node$i"
		sudo lxc-info -n "node$i" > logs/"node$i"/container_status.txt
		container_status=$(sudo lxc-ls --fancy | grep "node$i" | awk '{ print $2 }')
		node_rootfs="/var/lib/lxc/node$i/rootfs"
		node_logs="$node_rootfs/home/ubuntu/ipop/logs/."
		core_file="$node_rootfs/home/ubuntu/ipop/core"

		if [ -e $core_file ] ; then
			sudo cp $core_file ".logs/node$i"
		fi

		if [ "$container_status" = 'RUNNING' ] ; then
			sudo cp -r $node_logs "./logs/node$i"
		else
			echo "node$i is not running"
		fi
	done
fi
echo "View ./logs/ to see ctrl and tincan logs"
