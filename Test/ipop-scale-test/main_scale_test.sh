#!/bin/bash

OP_FILE="./config/config_scale_test.txt"
operation=''
subpath="./opscripts"

# functions
function configure-external-node
{
	echo -e "configuring external node\n"
	$subpath/configure_external_node.sh
	echo "completed configuration"
}
function check-vpn-mode
{
	echo -e "checking vpn mode\n"
	$subpath/check_vpn_mode.sh
	echo "completed check"
}
function install-support-serv
{
	echo -e "install support services\n"
	$subpath/install_support_serv.sh
	echo "completed installation"
}
function prep-def-container
{
	echo -e "preparing default container\n"
	$subpath/prep_def_container.sh
	echo "completed preparation"
}
function containers-create
{
	echo -e "creating containers\n"
	$subpath/containers_create.sh
	echo "completed containers creation"
}
function containers-start
{
	echo -e "starting containers\n"
	$subpath/containers_start.sh
	echo "completed containers start"
}
function containers-del
{
	echo -e "deleting containers\n"
	$subpath/containers_del.sh
	echo "completed containers deletion"
}
function containers-stop
{
	echo -e "stopping containers\n"
	$subpath/containers_stop.sh
	echo "completed containers stop"
}
function containers-update
{
	echo -e "updating containers\n"
	$subpath/container_update.sh
	echo "completed containers update"
}
function ipop-start
{
	echo -e "starting ipop\n"
	$subpath/ipop_start.sh
	echo "completed ipop start"
}
function ipop-stop
{
	echo -e "stopping ipop\n"
	$subpath/ipop_stop.sh
	echo "completed ipop stop"
}
function ipop-status
{
	echo -e "ipop status\n"
	$subpath/ipop_status.sh
	echo "completed ipop status"
}
function visualizer-start
{
	echo -e "starting visualizer\n"
	$subpath/visualizer_start.sh
	echo "completed visualizer start"
}
function visualizer-stop
{
	echo -e "stopping visualizer\n"
	$subpath/visualizer_stop.sh
	echo "completed visualizer stop"
}
function visualizer-status
{
	echo -e "visualizer status\n"
	$subpath/visualizer_status.sh
	echo "completed visualizer status"
}
function logs
{
	echo -e "displaying logs\n"
	$subpath/logs.sh
	echo "completed logs"
}
function mode
{
	echo -e "changing mode\n"
	$subpath/mode.sh
	echo "completed mode"
}
function help
{
	echo -e "displaying help info\n"
	$subpath/help.sh
	echo "completed help"
}

show_help=true
# first read config file
grep -v '^#' $OP_FILE | while IFS='' read -r line ; do
	wor=( $line  )
	operation=${wor[0]}
	user=${wor[1]}
	host=${wor[2]}
	userhost=$user@$host
	echo $userhost
	# line-by-line, so first checks if it is possible to ssh into machine
	check=$(ssh -T -q $userhost exit)
	resp=$?
	if [ "$(echo $resp)" = "255" ]; then
		echo "Cannot connect to $user@$host to complete operation: $operation"
	elif [ "$(echo $resp)" = "0" ]; then
		echo "Connecting to $user@$host to complete operation: $operation ........"
		if "$show_help" = true; then
        	echo "$(help)"
		fi
		#continue by calling the appropriate subscript for the 
		case $operation in
			("configure-external-node") 
			   show_help=true
			   ;;
			("check-vpn-mode") 
			   show_help=false
			   ;;
			("install-support-serv")
			   show_help=true
			   ;;
			("prep-def-container")
			   show_help=true
			   ;;
			("containers-create")
			   show_help=true
			   ;;
			("containers-start")
			   show_help=false
			   ;;
			("containers-del")
			   show_help=false
			   ;;
			("containers-stop")
			   show_help=false
			   ;;
			("containers-update")
			   show_help=true
			   ;;
			("ipop-start")
			   show_help=false
			   ;;
			("ipop-stop")
			   show_help=false
			   ;;
			("ipop-tests")
			   show_help=true
			   ;;
			("ipop-status")
			   show_help=false
			   ;;
			("visualizer-start")
			   show_help=false
			   ;;
			("visualizer-stop") 
			   show_help=false
			   ;;
			("visualizer-status") 
			   show_help=false
			   ;;
			("logs") 
			   show_help=false
			   ;;
			("mode") 
			   show_help=false
			   ;;
			("help") 
			   help
			   show_help=false
			   ;;
			*)
            	echo -n "Please input a valid option."
            	show_help=false
				;;

		esac
	fi
done

# it will send a script to run on the other machine
# most likely has to check that previous steps have been completed in chronological order

# expects to receive a log of activities and stores them for later reference

