#!/bin/bash

echo -e "\e[1;31mStopping containers... \e[0m"
for i in $(seq $min $max); do
	sudo lxc-stop -n "node$i"
done
