#!/bin/bash

#Rich W.
#Feb. 2024

SETOUTPUT=$(set | grep "terminator")
APPNAME="rwhifonline"
TABTITLETEXT="pm2 $APPNAME"
REMOTINATORRESULT=""

if [[ $SETOUTPUT != "" ]]
then
    echo "Gnome Fedora 39 style Terminator terminal shell detected."
    echo "Setting tab title and proceeding to start pm2 management of app ${APPNAME}"
	REMOTINATORRESULT=$(remotinator set_tab_title -t "$TABTITLETEXT")
else
    echo "'terminator' not found in shell set variables."
    echo "This is not a (Gnome Fedora 39) Terminator terminal command line."
    echo "Not setting the terminal tab to '"$TABTITLETEXT"'."
    echo "Proceeding to start pm2 management of app ${APPNAME}"
fi
pm2 start ecosystem.config.js && pm2 logs $APPNAME --lines 256
