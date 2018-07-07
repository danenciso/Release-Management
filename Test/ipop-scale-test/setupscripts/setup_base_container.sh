#!/bin/bash

# Install lxc
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt-get update -y
sudo apt-get -y install lxc

# Install ubuntu OS in the lxc-container
sudo lxc-create -n default -t ubuntu
sudo chroot /var/lib/lxc/default/rootfs apt-get -y update
sudo chroot /var/lib/lxc/default/rootfs apt-get -y install $DEFAULT_LXC_PACKAGES
sudo chroot /var/lib/lxc/default/rootfs apt-get -y install software-properties-common python3-software-properties

# install controller dependencies
if [ $VPNMODE = "switch" ]; then
	sudo pip3 install sleekxmpp psutil requests
else
	sudo chroot /var/lib/lxc/default/rootfs apt-get -y install python3-pip
	sudo chroot /var/lib/lxc/default/rootfs pip3 install sleekxmpp psutil requests
fi

config_grep=$(sudo grep "lxc.cgroup.devices.allow = c 10:200 rwm" "$DEFAULT_LXC_CONFIG")
if [ -z "$config_grep" ]; then
	echo 'lxc.cgroup.devices.allow = c 10:200 rwm' | sudo tee --append $DEFAULT_LXC_CONFIG
fi
