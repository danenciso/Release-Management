#!/bin/bash

# obtain network device and ip4 address
NET_TEST=$(ip route get 8.8.8.8)
NET_DEV=$(echo $NET_TEST | awk '{print $5}')
NET_IP4=$(echo $NET_TEST | awk '{print $7}')

MODELINE=$(cat $OVERRIDES_FILE | grep MODE)

# function parameters
if ! [ -z $1 ]; then
	container_count=$1
fi
if ! [ -z $2 ]; then
	visualizer_enabled=$2
else
	visualizer_enabled=$DEFAULT_VISUALIZER_ENABLED
fi

if [ -z "$container_count" ]; then
	read -p "No of containers to be created: " max
	else
	max=$container_count
fi
min=1
echo -e "MIN $min\nMAX $max" > $OVERRIDES_FILE
echo $MODELINE >> $OVERRIDES_FILE


if [ -z "$visualizer_enabled" ]; then
	echo -e "\e[1;31mEnable visualization? (Y/N): \e[0m"
	read visualizer_enabled
	if [[ "$visualizer_enabled" =~ [Yy](es)* ]]; then
		isvisual=true
	else
		isvisual=false
	fi
else
	isvisual=$visualizer_enabled
fi


echo -e "\e[1;31mStarting containers. Please wait... \e[0m"
if [[ "$VPNMODE" = "switch" ]]; then
	sudo mkdir -p /dev/net
	sudo rm /dev/net/tun
	sudo mknod /dev/net/tun c 10 200
	sudo chmod 0666 /dev/net/tun
	sudo chmod +x ./ipop-tincan
	sudo chmod +x ./node/node_config.sh
	sudo cp -r ./Controllers/controller/ ./

	sudo ./node/node_config.sh config 1 TUNNEL $NET_IP4 $isvisual
	sudo ejabberdctl register "node1" ejabberd password

	for i in $(seq $min $max); do
		sudo bash -c "
		lxc-copy -n default -N node$i;
		sudo lxc-start -n node$i --daemon;
		"
	done
else
	# currently unused
	lxc_bridge_address="10.0.3.1"
	for i in $(seq $min $max); do
		sudo bash -c "
		lxc-copy -n default -N node$i;
		sudo lxc-start -n node$i --daemon;
		sudo lxc-attach -n node$i -- bash -c 'sudo mkdir -p $IPOP_HOME; sudo mkdir /dev/net; sudo mknod /dev/net/tun c 10 200; sudo chmod 0666 /dev/net/tun';
		"
		sudo cp -r ./Controllers/controller/ "/var/lib/lxc/node$i/rootfs$IPOP_HOME"
		sudo cp ./ipop-tincan "/var/lib/lxc/node$i/rootfs$IPOP_HOME"
		sudo cp './node/node_config.sh' "/var/lib/lxc/node$i/rootfs$IPOP_HOME"
		sudo lxc-attach -n node$i -- bash -c "sudo chmod +x $IPOP_TINCAN; sudo chmod +x $IPOP_HOME/node_config.sh;"
		sudo lxc-attach -n node$i -- bash -c "sudo $IPOP_HOME/node_config.sh config $i VNET $NET_IP4 $isvisual $lxc_bridge_address"
		echo "Container node$i started."
		sudo ejabberdctl register "node$i" ejabberd password
		for j in $(seq $min $max); do
			if [ "$i" != "$j" ]; then
				sudo ejabberdctl add_rosteritem "node$i" ejabberd "node$j" ejabberd "node$j" ipop both
			fi
		done
	done
fi
#sudo rm -r Controllers
