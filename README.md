# Radioripper-CUI

A simple cui-wrapper for the streamripper-cli or any other radio ripping interface. Streamripper and player can be specified freely in the config.txt.

# Dependencies

- streamripper
- mplayer

# Usage

Streams can be added to the config by either using the 'streams add' command or by manually adding them to the config.txt.
The stream configurations follow the pattern:

[1]... [10]... [n]
name=Station
description=Station description
tags=News Charts etc. 
url=streamurl

After streams are configured, it is possible to listen to or rip them. This can be achieved by:

- listen streamnumber
- rip streamnumber

For example: listen/rip 1

The rip function uses the streamripper package available on most distributions. The default player is set to mplayer. However the command line for listening/recording can be set freely in the config.txt, so other packages are supported as well, as long as they are able to make use of the cli option.

# TODO:

- make terminal easily changeable e.g config-file(DONE)
- draw save path from config (DONE)
- caps/lower case for search
- make tags partly searchable
- return all tags
- able to add streams (DONE)
