#!/bin/bash

#Rich W.
#Dec. 2024

SETOUTPUT=$(set | grep "terminator")
TABTITLETEXT="$1"
REMOTINATORRESULT=""

if [[ $SETOUTPUT != "" ]]
then
    echo "Terminator style terminal emulator shell detected."
    echo "Setting tab title to ${TABTITLETEXT}"
    REMOTINATORRESULT=$(remotinator set_tab_title -t "$TABTITLETEXT")
else
    echo "'terminator' not found in shell set variables."
    echo "Not setting the terminal tab to '"$TABTITLETEXT"'."
fi
