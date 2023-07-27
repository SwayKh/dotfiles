#!/bin/sh

pid=$(pgrep wf-recorder)

# echo $pid

if [[ $pid == "" ]]; then
	echo "wf-recorder not running"
	exit 1
fi	

kill -s 2 $pid
