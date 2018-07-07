#!/bin/bash

action=$1
current_vpn_mode=$(cat $OVERRIDES_FILE 2>/dev/null | grep MODE | awk '{print $2}')
case $action in
	"change")
		if [[ "$current_vpn_mode" == "classic" ]]; then
			sed -i "s/MODE .*/MODE switch/g" $OVERRIDES_FILE
			echo "Mode changed to switch."
		else
			sed -i "s/MODE .*/MODE classic/g" $OVERRIDES_FILE
			echo "Mode changed to classic."
		fi
	;;
	*)
		echo "Current mode: $current_vpn_mode"
	;;
esac
