#!/bin/bash

visualizer_ps_result=$(ps aux | grep "[D]eploymentServer")

if [ -n "$visualizer_ps_result" ] ; then
	echo 'Visualizer is UP'
else
	echo 'Visualizer is Down'
fi
