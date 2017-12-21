#!/bin/bash

read -p 'Enter filename: ' file 
if [ -f $file ]; then 
	echo "File OK"
else
	echo "File NOTOK"
fi
