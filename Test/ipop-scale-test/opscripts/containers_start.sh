#!/bin/bash

echo -e "\e[1;31mStarting containers... \e[0m"
for i in $(seq $min $max); do
	sudo bash -c "sudo lxc-start -n node$i --daemon;"
	echo "Container node$i started."
done
