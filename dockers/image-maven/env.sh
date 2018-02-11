#!/bin/bash

if [ -z "$REPO_URL" ]; then 
    echo "Please pass REPO_URL env variables"
    exit 1
fi

git clone --depth=1 $REPO_URL
if [ $? -ne 0 ]; then   
    echo "Issue with Git repo URL"
    exit 1
fi 

REPO_DIR=$(echo $REPO_URL |awk -F / '{print $NF}' | sed -e 's/.git$//')
cd $REPO_DIR
mvn package

/bin/cp -v target/*.war /repos