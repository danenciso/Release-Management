#!/bin/bash

echo -e "\e[1;31mDeleting containers... \e[0m"
for i in $(seq $min $max); do
	if [ $VPNMODE = "classic" ]; then
		for j in $(seq $min $max); do
			if [ "$i" != "$j" ]; then
				sudo ejabberdctl delete_rosteritem "node$i" ejabberd "node$j" ejabberd
			fi
		done
		sudo ejabberdctl unregister "node$i" ejabberd
	fi
	sudo lxc-stop -n "node$i"
	sudo lxc-destroy -n "node$i"
done
