#!/bin/bash

username=$1
hostname=$2
xmpp_address=$3

if [ -z "$username" ]; then
	read -p "Enter username: " username
fi
if [ -z "$hostname" ]; then
	read -p "Enter hostname: " hostname
fi
if [ -z "$xmpp_address" ]; then
	read -p "Enter xmpp server address: " xmpp_address
fi

scp ./external/external_setup.sh $username@$hostname:
ssh "$username@$hostname" -t "sudo ./external_setup.sh $xmpp_address"

