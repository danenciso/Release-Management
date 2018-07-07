#!/bin/bash

if [ -z $VPNMODE ] ; then
	echo -e "Select vpn mode to test. Please input 1 for classic or 2 for switch."
	read VPNMODE_CODE
	while [ -z $VPNMODE_CODE ] || ([ "$VPNMODE_CODE" != "1" ] && [ "$VPNMODE_CODE" != "2" ]) ; do
		echo -e "Incorrect input. Please input 1 for classic or 2 for switch."
		read VPNMODE_CODE
	done

	if [ "$VPNMODE_CODE" == "1" ] ; then
		VPNMODE="classic"
	else
		VPNMODE="switch"
	fi
	echo "MODE $VPNMODE" >> $OVERRIDES_FILE
fi
