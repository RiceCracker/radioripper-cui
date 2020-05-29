#!/bin/bash
#

#Parameters
#file="../config.txt"


#Functions
getStreamData() #Enter stream number + data type
	{
		data=$(sed -nr "/^\[$1\]/ { :l /^$2[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" ${file})
		echo $data
	}

getStreamCount() 
	{
		stream_count=$(grep -c "^\[[0-9]\+]" ${file})
		echo $stream_count
		return $stream_count
	}

isTagged() # Check if $1 station has tag in tags
	{
	station=$1
	found=0
	
	# getting stations with tag
	tags=$(getStreamData $station tags)
				
	for tag in $tags; do 
		if [[ "$@" == *$tag* ]]; then
			found=1
			continue	
		fi
	done 
	
	echo $found
	
	}

printTags() # Returns all existing Tags
	{
		echo
	}
	
printStreams()
	{
		echo
		echo -------------------------------
		echo RadioRipper - available streams
		echo -------------------------------
		echo
		
		for (( station=1; station<=$(getStreamCount); station++ ))
		do
			if [[ "$1" == *"-t"* ]]; then
					bool=$(isTagged $station $2)
					if [ $bool != 1 ]; then
						continue
					fi
			fi
			printDetail $station "$@" 
		done
		
		echo
		echo
			
	}

printDetail() # Print one stations details
	{
		echo -e [$1] $(getStreamData $1 name)
						
		#if [[ "$@" == *"name"* ]] || [[ "$@" == *"detail"* ]]; then
		#	echo -e "\t"$(getStreamData $1 name)
		#fi
		if [[ "$@" == *"description"* ]] || [[ "$@" == *"detail"* ]]; then
			echo -e "\tBeschreibung: "$(getStreamData $1 description)
		fi
		if [[ "$@" == *"tags"* ]] || [[ "$@" == *"detail"* ]]; then
			echo -e "\tTags:         "$(getStreamData $1 tags)
		fi
		if [[ "$@" == *"url"* ]] || [[ "$@" == *"detail"* ]]; then
			echo -e "\tAdresse:      "$(getStreamData $1 url) "\n"
		fi
	}

addStream()
	{
		streamID=$(getStreamCount)
		streamID=$(( $streamID + 1 ))
		
		S1="\$a["$streamID"]"
		
		# Stream name
		echo -n "Enter stream name [ENTER]: "
		read name
		S2="name="$name
		echo $S2
		# Description
		echo -n "Enter stream description [ENTER]: "
		read description
		S3="description="$description
		echo $S3
		# Tags
		echo -n "Enter stream tags [ENTER]: "
		read tags
		S4="tags="$tags
		echo $S4
		# Url
		echo -n "Enter stream url [ENTER]: "
		read url
		S5="url="$url
		echo $S5
		
		sed -i -e '$a\' $file
		sed -i -e $S1"\n"$S2"\n"$S3"\n"$S4"\n"$S5"\n" $file
		
	}
