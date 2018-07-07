#!/bin/bash

setuppath="../setupscripts"

setup-python

setup-mongo

#configure iptables needed for proper network connectivity
setup-network

#Install and setup ejabberd with admin user
setup-ejabberd

setup-visualizer

# In switch mode, this node needs to run the vswitch
if [[ "$VPNMODE" = "switch" ]]; then
sudo apt-get install -y openvswitch-switch
fi
