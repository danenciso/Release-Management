#!/bin/bash

containers-stop
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
	sudo lxc-attach -n node$i -- bash -c "sudo $IPOP_HOME/node_config.sh config $i GroupVPN $NET_IP4 $isvisual $topology_param containeruser password"
	echo "Container node$i started."
done
