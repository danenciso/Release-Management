#!/bin/bash

# Install local ejabberd server
sudo apt-get -y install ejabberd
echo "ejabberd has been installed!"
echo "IMPORTANT!!! Please note that the default configuration file for ejabberd has an issue with
a memory permission which prevents it from starting up successfully. Do you wish to replace the existing
configuration file with the one we recommend? This will overwrite ALL your changes (if you have made any)."

read -p "Replace ejabberd config with recommended one? [y/N] " replace_ejabberd_config
if [[ $replace_ejabberd_config =~ [Yy](es)* ]]; then
	echo "Copying apparmor profile for ejabberdctl..."
	sudo cp ./config/usr.sbin.ejabberdctl /etc/apparmor.d/usr.sbin.ejabberdctl
	echo "Reloading apparmor profile for ejabberd..."
	sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.ejabberdctl
	echo "Done!"
fi

# prepare ejabberd server config file
# restart ejabberd service
if [ $OS_VERSION = '14.04' ]; then
	sudo cp ./config/ejabberd.cfg /etc/ejabberd/ejabberd.cfg
	sudo ejabberdctl restart
else
	sudo apt-get -y install erlang-p1-stun
	sudo cp ./config/ejabberd.yml /etc/ejabberd/ejabberd.yml
	sudo systemctl restart ejabberd.service
fi
# Wait for ejabberd service to start
sleep 15
# Create admin user
sudo ejabberdctl register admin ejabberd password
