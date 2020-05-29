#!/bin/bash

source lib/streaminfo.sh
#file="../streams.txt"

playStream() 
	{
		# Play stream with player configured in [config]
		eval  $(sed -nr "/^\[config\]/ { :l /^player[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" ${file}) $(getStreamData $1 url) &
	}

ripStream()
	{
		# Rip Stream with ripper specified in [config]
		eval $(sed -nr "/^\[config\]/ { :l /^ripper[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" ${file}) $(getStreamData $1 url) $(sed -nr "/^\[config\]/ { :l /^params[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" ${file}) &
	}
