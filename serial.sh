#!/bin/bash

OPTIND=1
encode=1
cloud=0

while getopts ":dc" opt
do
    case $opt in
	d)
	    encode=0
	    ;;
	c)
	    cloud=1
	    ;;
	\?)
	    echo "Invalid option -$OPTARG"
	    exit 1
	    ;;
	esac
done
shift $((OPTIND-1))

if [ $encode -eq 0 ] && [ $cloud -eq 1 ]
then
    echo "You can't use '-d' and '-c' at the same time"
    exit 2
fi


if (($encode)) && (($cloud))
then
    cat $1 | base64 |& curl -s -F 'f:1=<-' ix.io
elif (($encode))
then
    cat $1 | base64
else
    cat $1 | base64 -d
fi
