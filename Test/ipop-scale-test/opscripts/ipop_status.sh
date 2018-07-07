#!/bin/bash

for i in $(seq $min $max); do
	container_status=$(sudo lxc-ls --fancy | grep "node$i" | awk '{ print $2 }')
	if [ "$container_status" = 'RUNNING' ] ; then
		ctrl_process_status=$(sudo lxc-attach -n "node$i" -- bash -c 'ps aux | grep "[c]ontroller.Controller"')
		tin_process_status=$(sudo lxc-attach -n "node$i" -- bash -c 'ps aux | grep "[i]pop-tincan"')

		if [ -n "$ctrl_process_status" ]; then
			ctrl_real_status="Controller is UP"
		else
			ctrl_real_status="Controller is DOWN"
		fi

		if [ -n "$tin_process_status" ]; then
			echo "$ctrl_real_status && Tincan is UP on node$i"
		else
			echo "$ctrl_real_status && Tincan is DOWN on node$i"
		fi

	else
		echo -e "node$i is not running"
	fi
done
