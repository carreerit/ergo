#!/bin/bash

if [ -z "$APP_URL" ]; then 
    echo "URL for APP is missing, Please provide nexus url"
    exit 1
fi 

wget $APP_URL -O /apache-tomcat-8.5.27/webapps/student.war 
/apache-tomcat-8.5.27/bin/catalina.sh run