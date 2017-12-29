#!/bin/bash

ps -ef | grep httpd | grep -v grep &>/dev/null
if [ $? -eq 0 ]; then 
	echo OK
	exit 
fi
sleep 300 
ps -ef | grep httpd | grep -v grep &>/dev/null
if [ $? -eq 0 ]; then 
	echo OK
	exit 
else
	echo ERROR
	exit 1
fi
