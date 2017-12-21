#!/bin/bash

## COLORS
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

## Variables
CONN_URL="http://redrockdigimark.com/apachemirror/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.42-src.tar.gz"
CONN_TAR_FILE=$(echo $CONN_URL | cut -d / -f8)  # echo $CONN_URL | awk -F / '{print $NF}'
CONN_TAR_DIR=$(echo $CONN_TAR_FILE | sed -e 's/.tar.gz//')

TOMCAT_URL=$(curl -s https://tomcat.apache.org/download-90.cgi | grep Core -A 20 | grep nofollow | grep tar.gz | awk -F '"' '{print $2}' )
TOMCAT_TAR_FILE=$(echo $TOMCAT_URL | awk -F / '{print $NF}')
TOMCAT_TAR_DIR=$(echo $TOMCAT_TAR_FILE | sed -e 's/.tar.gz//')

WAR_URL="https://github.com/carreerit/cogito/raw/master/appstack/student.war"
JDBC_URL="https://github.com/carreerit/cogito/raw/master/appstack/mysql-connector-java-5.1.40.jar"


## FUnctions
VALIDATE() {
	if [ $1 -eq 0 ]; then 
		echo -e "$2 .. $G SUCCESS $N"
	else
		echo -e "$2 .. $R FAILURE $N"
		exit 1
	fi
}

SKIP() {
	echo -e "$1 .. $Y SKIPPING $N"
}

############
ID=`id -u`
if [ $ID -ne 0 ]; then 
	echo "You Should be root user to perform this Script"
	exit 2
fi

##
LOG=/tmp/stack
rm -f /tmp/stack

echo "Installing WEB Server"
yum install httpd httpd-devel gcc -y &>>$LOG
VALIDATE $? "Installing HTTPD"

systemctl enable httpd &>>$LOG
systemctl start httpd  &>>$LOG
VALIDATE $? "Starting HTTPD"

if [ -f /opt/$CONN_TAR_FILE ]; then 
	SKIP "Downloadng MOD-JK" 
else
	wget $CONN_URL -O /opt/$CONN_TAR_FILE &>>$LOG
	VALIDATE $? "Downloadng MOD-JK"
fi

cd /opt 
if [ -d $CONN_TAR_DIR ]; then 
	SKIP "Extracting MOD-JK"
else
	tar xf $CONN_TAR_FILE &>>$LOG 
	VALIDATE $? "Extracting MOD-JK"
fi

if [ -f /etc/httpd/modules/mod_jk.so ]; then 
	SKIP "Compiling MOD-JK"
else
	cd /opt/$CONN_TAR_DIR/native 
	./configure --with-apxs=/bin/apxs &>>$LOG && make clean &>>$LOG  && make  &>>$LOG && make install &>>$LOG
	VALIDATE $? "Compiling MOD-JK"
fi



echo -e "\nInstalling APP Server"	

yum install java -y &>>$LOG
VALIDATE $? "Installing JAVA"

if [ -f /opt/$TOMCAT_TAR_FILE ]; then 
	SKIP "Downloading TOMCAT"
else
	wget $TOMCAT_URL -O /opt/$TOMCAT_TAR_FILE &>>$LOG 
	VALIDATE $? "Downloading TOMCAT"
fi

if [ -d $TOMCAT_TAR_DIR ]; then 
	SKIP "Extracting TOMCAT"
else
	cd /opt
	tar xf /opt/$TOMCAT_TAR_FILE
	VALIDATE $? "Extracting TOMCAT"
fi


rm -rf /opt/$TOMCAT_TAR_DIR/webapps/*

if [ -f /opt/$TOMCAT_TAR_DIR/lib/mysql-connector-java-5.1.40.jar ]; then 
	SKIP "Downloading JDBC JAR File"
else
	wget $JDBC_URL -O /opt/$TOMCAT_TAR_DIR/lib/mysql-connector-java-5.1.40.jar &>>$LOG
	VALIDATE $? "Downloading JDBC JAR File"
fi

wget $WAR_URL -O /opt/$TOMCAT_TAR_DIR/webapps/student.war  &>>$LOG 
VALIDATE $? "Downloading WAR File"

sed -i -e '/TestDB/ d' /opt/$TOMCAT_TAR_DIR/conf/context.xml 
sed -i -e '$ i <Resource name="jdbc/TestDB" auth="Container" type="javax.sql.DataSource" maxTotal="100" maxIdle="30" maxWaitMillis="10000" username="student" password="student@1" driverClassName="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/studentapp"/>' /opt/$TOMCAT_TAR_DIR/conf/context.xml 


echo -e "\nInstalling DB Server"

yum install mariadb mariadb-server -y &>>$LOG
VALIDATE $? "Installing DB"

systemctl enable mariadb &>>$LOG
systemctl start mariadb 
VALIDATE $? "Starting DB Server"

echo "create database if not exists studentapp;
use studentapp;
CREATE TABLE if not exists Students(student_id INT NOT NULL AUTO_INCREMENT,
	student_name VARCHAR(100) NOT NULL,
    student_addr VARCHAR(100) NOT NULL,
	student_age VARCHAR(3) NOT NULL,
	student_qual VARCHAR(20) NOT NULL,
	student_percent VARCHAR(10) NOT NULL,
	student_year_passed VARCHAR(10) NOT NULL,
	PRIMARY KEY (student_id)
);
grant all privileges on studentapp.* to 'student'@'localhost' identified by 'student@1';" >/tmp/student.sql 
mysql < /tmp/student.sql 
VALIDATE $? "Importing DB"