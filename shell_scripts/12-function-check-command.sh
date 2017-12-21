#!/bin/bash

VALIDATE() {
	if [ $1 -eq 0 ]; then 
		echo "$2 .. Success"
	else
		echo "$2 .. failure"
	fi
}

## Main program

yum install httpd -y &>/dev/null
VALIDATE $? "YUM Install of HTTPD "

sudo systemctl enable httpd &>/dev/null
sudo systemctl start httpd &>/dev/null
VALIDATE $? "Starting HTTPD "