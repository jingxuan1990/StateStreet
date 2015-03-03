#!/bin/bash

#################
#
# Author       : Andy
# Date         : 29/01/2015
# Description  : Detect the server whether is running or not
#
#################

temp_file=temp_content
url="http://www.cnblogs.com"

################
# Try to connect the server and output the result to the specified file
################
function connect_output(){
    curl -I -o $temp_file --connect-timeout 5 $url > /dev/null 2>&1
}

if [ -f $temp_file ]; then
    rm -f $temp_file
fi

# umask 0002
touch $temp_file

declare -i count=0

while [ -z "$result" ]
do
    count=$(($count+1))
    connect_output
    result=`grep "^HTTP/[0-9].[0-9].*200" $temp_file`

    if [ -n "$result" ]; then
        echo "The remote server is running..."
        exit 0
    fi

    if [ -z "$result" ] && [ $count -ge 100 ]; then
        exit 100
    fi

    sleep 2
done

########## Remove the temp file ##########
#rm -rf  $temp_file
