#!/bin/bash

echo 'Enter from the following options:
install-support-serv           : install critical services used in both, classic and switch modes
prep-def-container             : prepare default container (what goes in depends on the mode)
containers-create              : create and start containers
containers-update              : restart containers adding IPOP src changes
containers-start               : start stopped containers
containers-stop                : stop containers
containers-del                 : delete containers
ipop-start                     : to start IPOP processes
ipop-stop                      : to stop IPOP processes
ipop-tests                     : open scale test shell to test ipop
ipop-status                    : show statuses of IPOP processes
visualizer-start               : install and start up visualizer
visualizer-stop                : stop visualizer processes
visualizer-status              : show statuses of visualizer processes
logs                           : aggregate ipop logs under ./logs
mode                           : show or change ipop mode to test
help                           : show this menu
quit                           : quit
'
