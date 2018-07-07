#!/bin/bash

container_to_run=$1

if [ $VPNMODE = "switch" ]; then
	echo "Running ipop in switch-mode"
	sudo chmod 0666 /dev/net/tun
	mkdir -p logs/
	nohup sudo -b ./ipop-tincan &
	nohup sudo -b python3 -m controller.Controller -c ./node/ipop-config.json &
else
	if [[ ! ( -z "$container_to_run" ) ]]; then
		if [ "$container_to_run" = '#' ]; then
			for i in $(seq $min $max); do
				echo "Running node$i"
				sudo lxc-attach -n "node$i" -- nohup bash -c "cd $IPOP_HOME && ./node_config.sh run"
				sleep 0.5
			done
		else
			echo "Running node$container_to_run"
			sudo lxc-attach -n "node$container_to_run" -- nohup bash -c "cd $IPOP_HOME && ./node_config.sh run"
		fi
	else
		echo -e "\e[1;31mEnter # To RUN all containers or Enter the container number.  (e.g. Enter 1 to start node1)\e[0m"
		read user_input
		if [ $user_input = '#' ]; then
			for i in $(seq $min $max); do
				echo "Running node$i"
				sudo lxc-attach -n "node$i" -- nohup bash -c "cd $IPOP_HOME && ./node_config.sh run"
				sleep 0.5
			done
		else
			echo "Running node$user_input"
			sudo lxc-attach -n "node$user_input" -- nohup bash -c "cd $IPOP_HOME && ./node_config.sh run"
		fi
	fi
fi
