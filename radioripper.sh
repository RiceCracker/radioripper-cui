#!/bin/bash
cd "$(dirname "$0")"

source lib/streaminfo.sh
source lib/streaming.sh

# Params
file="config.txt"

while [[ $# -gt 1 ]]
do
    key1="$1"
    key2="$2"
    key3="$3"
    key4="$4"
    key5="$5"
    
    shift
    
    case $key1 in
		streams)
			
			if [ "$key2" == "detail" ] || [ "$key2" == "-t" ] || [ "$key2" == "" ]; then
				printStreams "$key2" "$key3" "key4" "key5"
			fi
			if [ "$key2" == "add" ]; then
				addStream
			fi
			shift
			;;
		listen)
			if [ "$key2" == "" ]; then
				printStreams "$key2" "$key3" "key4" "key5"
			else
				playStream "$key2"
			fi
			;;
		rip)
			if [ "$key2" == "" ]; then
				printStreams "$key2" "$key3" "key4" "key5"
			else
				ripStream "$key2"
			fi
			;;
	esac
	shift
done

if [[ -n $1 ]]; then
    printStreams
fi
