#!/bin/sh

OPTIND=1
encode=true
cloud=false

while getopts ":dc" opt
do
    case $opt in
	d)
	    encode=false
	    ;;
	c)
	    cloud=true
	    ;;
	\?)
	    echo "Invalid option -$OPTARG"
	    exit 1
	    ;;
	esac
done
shift $((OPTIND-1))

if [ $encode = false ] && [ $cloud = true ]
then
    echo "You can't use '-d' and '-c' at the same time"
    exit 2
fi


if [ $encode = true ] && [ $cloud = true ]
then
     base64 "$1" 2>&1 | curl -s -F 'f:1=<-' ix.io
elif [ $encode = true ]
then
    #cat "$1" | base64
    base64 "$1"
else
    #cat "$1" | base64 -d
    base64 -d "$1"
fi
