#!/bin/bash
# copyrights pending Rich W.
# license MSL.l otherwise
# quick startup script launcher
# initially written 5/22/2019
# messaging level numbering added 6/14/2019
# sanitized for GitHub 3/10/2024

# INSTRUCTIONS:
#   1) configure scripts and parallel arrays with startup launch tasks
#   2) place in useful directory
#   3) run scripts with menu-selection ease.

# TODO: print output for which menu item is selected by number if verbosity sufficient
# TODO: check bash version and warn if mismatch
# TODO: add possibility of secret menu options not listed by improving input matching loop

# maybe: read menu items from separate file option
# maybe: zero(?) option to readline inputs for new menu item then save to external file



# Output Message Level Numbering
let Emergency=0
let Critical=1
let Error=2
let Warning=3
let Notification=4
let Debug=5


# initialize program constants
let messageoutputlevel=5
readonly expectedusername=''
readonly expectedhostname=''
readonly numberre='^[0-9]+$'
readonly exitselection='Exit, do nothing.'


# script banner
printf '\n'
printf '\n'
echo 'QUICKMENU STARTUP SCRIPT-LAUNCHER'
echo '---------------------------------'


# username safety check
if [[ "$expectedusername" == '' ]]
then
    echo "Hardcoded expectedusername string match safety check not configured."
elif [[ "$USER" != "$expectedusername" ]]
then
    echo "Expected username safety check failed, exiting."
    exit 1
fi
# hostname safety check
if [[ "$expectedhostname" == '' ]]
then
    echo "Hardcoded expectedhostname string match safety check not configured."
elif [[ "$HOSTNAME" != "$expectedhostname" ]]
then
    echo "Expected hostname safety check failed, exiting."
    exit 1
fi
if [[ $messageoutputlevel > $Warning ]]
then
    if [[ "$expectedusername" != '' || "$expectedhostname" != '' ]]
    then
        echo 'Safety check(s) passed.'
    fi
fi


# initialize array of startup script selections
# 'scripts' are descriptive strings displayed to user.
# (scriptpaths are relative to r)
declare -a scripts=()
declare -a scriptpaths=()
declare -a scripCMNDs=()
#
# add menu selection and associated data template (Start)
#
scripts+=('Run an integer test script with an integer argument.')
scriptpaths+=('.')
scriptCMNDs+=('./integer-regex-test.sh 1')
#
scripts+=('Run an integer test script with a non-integer argument.')
scriptpaths+=('.')
scriptCMNDs+=('./integer-regex-test.sh a')
#
# # # blank template
# scripts+=('')
# scriptpaths+=('')
# scriptCMNDs+=('')
#
# this special exit option allows the user to exit the quickmenu gracefully
scripts+=("$exitselection")
scriptpaths+=('')
scriptCMNDs+=('')
#
# add menu selection and associated data template (End)
#

# check for command line argument
if ! [[ -z $1 ]]
then
    if ! [[ $1 =~ $numberre ]]
    then
        echo 'Input argument was not an integer number, displaying menu options.'
    else
        let selection="$1"
        if [[ $messageoutputlevel > $Warning ]]
        then
            echo 'Input argument was a valid integer number,'
            echo 'auto-selecting from menu options.'
        fi
    fi
fi


# if no CLI argument input was found, display menu and read user input
if [[ -z $selection ]]
then
    # display menu
    printf '\n'
    echo 'quickmenu selection menu:'
    printf '\n'
    let qmcounter=1
    for menustrng in "${scripts[@]}"
    do
        echo "${qmcounter})" "${menustrng}"
        let qmcounter++
    done

    # read user input
    echo 'Please enter the number of the startup script you want to run:'
    read selection
fi


# interpret input
# first check if input is a number
if ! [[ $selection =~ $numberre ]]
then
    echo 'Input Error: expected input should be an integer number.  Exiting script.'
    exit 1
fi
# check that input number is within the array boundary
if [[ "$selection" -gt ${#scriptCMNDs[*]} ]]
then
    echo 'Input Error: integer outside expected range, exiting script.'
    exit 1
fi
#
printf '\n'
printf '\n'
let arrindex=selection-1
# check if user selected exit option
if [[ "${scripts[arrindex]}" == "$exitselection" ]]
then
    echo 'Exiting script, no action taken.'
    exit 0
fi
#
# find the selected command and run it
for inputstr in "${scripts[@]}"
do
    if [[ "${scripts[arrindex]}" == "$inputstr" ]]
    then
        if [[ $messageoutputlevel > $Notification ]]
        then
            echo 'Selection' ${selection} 'recognized, running script.'
        fi
        if [[ "${scriptpaths[arrindex]}" != '.' ]]
        then
            cd "${scriptpaths[arrindex]}"
        fi
        ${scriptCMNDs[arrindex]}
        exit 0
    fi
done

if [[ $messageoutputlevel >= $Notification ]]
then
    echo 'Selection number' $selection 'not recognized,'
    echo 'no action taken, script complete.'
fi
exit 0
