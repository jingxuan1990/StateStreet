#!/bin/bash

############
#
# Author: Andy
# Description: Get Log info from file or directory
# Date:  4/2/2015
############

############
# Get Line Number and File Path for Log files
############

proi=$1
path=$2

current_path=`pwd`

log_result="log_result_file"
abs_path="$2"
abs_path=${abs_path%/} # remove '/' from string end
abs_log_result=$current_path"/$log_result"
proi=`echo $proi | tr '[a-z]' '[A-Z]'` # lower to upper

#echo "abs_log_result: $abs_log_result"
#echo "current_path: $current_path"
#echo "abs_path: $abs_path"

function get_log(){
    line_number=`grep -n "$proi" $1 | awk 'BEGIN {FS=":"} {print $1}'`
      
    for current_line in ${line_number[@]}
    do
        file=`echo $1 | egrep -i '.out$|.log$'`
        if test -z $file; then
            continue
        fi
        
        echo "abs_current_file: $1"
        echo -e "file: $1,   line_number: $current_line\n" >> $abs_log_result
    done
}

function get_log_dir(){
    current_path=$1
    file_names=`ls $current_path`
    
    for name in ${file_names[@]}
    do  
        file=`echo $name | egrep -i '.out$|.log$'`
        if test -z $file; then
            continue
        fi
        
        abs_current_file=$current_path"/$name"
        echo "abs_current_file: $abs_current_file"
        
        if test -f $abs_current_file; then
            get_log $abs_current_file
        fi
        
        if test -d $abs_current_file; then
            get_log_dir $abs_current_file
        fi
        
    done
}

function usage(){
   echo 'Usage: ./log.sh error_type(info,error,debug) file(directory)'
   echo 'Example:'
   echo '        ./log.sh INFO /usr/local/clo/app/mow/runtime/demo/logs/'
}

if test $# -eq 0; then
    usage
    exit 0
fi

if test $# -le 1; then
    echo "ERROR: The error_type(info,error,debug) and file(directory) must exist!"
    exit 0
fi

#If the path is directory, it must be started with '/'
if test -d $abs_path; then
    bool=`echo $abs_path | grep '^/'`
    if test -z $bool; then
        echo "The path must be started with '/'"
        exit 4
    fi
fi

if test -z "$1"; then
    proi="ERROR"
fi

#proi_res=`echo $proi | egrep -i 'debug|info|error'`
#if test -z $proi_res; then
#    echo "You can only input 'ERROR', 'INFO' OR 'DEBUG' for this first option!"
#    exit 2
#fi

if test -e $abs_log_result; then
    echo "" > $abs_log_result
else
    umask 0002
    touch $abs_log_result
fi

case $proi in
    "ERROR" | "INFO" | "DEBUG")
        echo -e "TYPE: "$proi"\n" >> $abs_log_result
    ;;
    *)
        echo "You can only input 'ERROR', 'INFO' OR 'DEBUG' for this first option!"
    ;;
esac      

if test ! -e $abs_path; then
    echo "Sorry, This $abs_path don't exist!"
    exit 1  # code 1 represent file or abs_path can't be found
fi

# If the $abs_path is just a file
if test -f $abs_path; then
    get_log $abs_path
fi

# If the $abs_path is dir
if test -d $abs_path; then
    files=`ls $abs_path`
    
    for file in ${files[@]}
    do
        current_file=$abs_path"/$file"
        if test -f $current_file; then
            get_log $current_file
        fi
        
        if test -d $current_file; then
            get_log_dir $current_file
        fi
    done
fi

exit 0
