#!/bin/bash

## Variables
CONN_URL="http://redrockdigimark.com/apachemirror/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.42-src.tar.gz"
CONN_TAR_FILE=$(echo $CONN_URL | cut -d / -f8)  # echo $CONN_URL | awk -F / '{print $NF}'
CONN_TAR_DIR=$(echo $CONN_TAR_FILE | sed -e 's/.tar.gz//')

ID=`id -u`
if [ $ID -ne 0 ]; then 
	echo "You Should be root user to perform this Script"
	exit 2
fi

##
LOG=/tmp/stack
rm -f /tmp/stack

echo "Installing Web Server"
yum install httpd httpd-devel gcc -y &>>$LOG
if [ $? -ne 0 ]; then 
	echo "YUM Command install .. FAILURE"
	exit 1
fi
echo "YUM httpd install .. SUCCESS"

systemctl enable httpd &>>$LOG
systemctl start httpd  &>>$LOG
if [ $? -ne 0 ]; then 
	echo "HTTPD Startup .. FAILURE"
	exit 1
fi

wget $CONN_URL -O /opt/$CONN_TAR_FILE &>>$LOG
if [ $? -ne 0 ]; then 
	echo "Downloading MOD-JK .. FAILURE"
	exit 1
fi 

cd /opt 
tar xf $CONN_TAR_FILE &>>$LOG 
if [ $? -ne 0 ]; then 
	echo "Extracting MOD-JK .. FAILURE"
	exit 1
fi

cd /opt/$CONN_TAR_DIR/native 
./configure --with-apxs=/bin/apxs &>>$LOG && make clean &>>$LOG  && make  &>>$LOG && make install &>>$LOG
if [ $? -ne 0 ]; then 
	echo "Compiling MOD-JK .. FAILURE"
	exit 1
fi




	



