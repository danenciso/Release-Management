#!/bin/bash

container_to_kill=$1
# kill IPOP tincan and controller
if [ $VPNMODE = "switch" ]; then
	sudo ./node/node_config.sh kill
else
	if [[ ! ( -z "$container_to_kill" ) ]]; then
		if [ "$container_to_kill" = '#' ]; then
			for i in $(seq $min $max); do
				sudo lxc-attach -n node$i -- bash -c "sudo $IPOP_HOME/node_config.sh kill"
			done
		else
			sudo lxc-attach -n node$container_to_kill -- bash -c "sudo $IPOP_HOME/node_config.sh kill"
		fi
	else
		echo -e "\e[1;31mEnter # To KILL all containers or Enter the container number.  (e.g. Enter 1 to stop node1)\e[0m"
		read user_input
		if [ $user_input = '#' ]; then
			for i in $(seq $min $max); do
				sudo lxc-attach -n node$i -- bash -c "sudo $IPOP_HOME/node_config.sh kill"
			done
		else
			sudo lxc-attach -n node$user_input -- bash -c "sudo $IPOP_HOME/node_config.sh kill"
		fi
	fi
fi
