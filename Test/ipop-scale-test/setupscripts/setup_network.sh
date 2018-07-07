#!/bin/bash

# configure network
#sudo iptables --flush
read -p "Use symmetric NATS? (Y/n) " use_symmetric_nat
if [[ $use_symmetric_nat =~ [Nn]([Oo])* ]]; then
	# replace symmetric NATs (MASQUERAGE) with full-cone NATs (SNAT)
	sudo iptables -t nat -A POSTROUTING -o $NET_DEV -j SNAT --to-source $NET_IP4
#else
	#    sudo iptables -t nat -A POSTROUTING -o $NET_DEV -j MASQUERADE
fi

# open TCP ports (for ejabberd)
for i in 5222 5269 5280; do
	sudo iptables -A INPUT -p tcp --dport $i -j ACCEPT
	sudo iptables -A OUTPUT -p tcp --dport $i -j ACCEPT
done
# open UDP ports (for STUN and TURN)
for i in 3478 19302; do
	sudo iptables -A INPUT -p udp --sport $i -j ACCEPT
	sudo iptables -A OUTPUT -p udp --sport $i -j ACCEPT
done
