#!/bin/bash

# integer-regex-test.sh
# initially 'test.sh'
# Rich W.
# 5/26/2019, 3/10/2024
# MSL.l

# tests command line input arguments with a regular expression

readonly numberre='^[0-9]+$'

if ! [[ -z $1 ]]
then
echo 'Input argument: '"$1"
    if ! [[ $1 =~ $numberre ]]
    then
        echo 'Input argument was not an integer number.'
    else
        echo 'Input argument was an integer number.'
    fi
else
    echo 'No input argument detected.'
fi

echo 'Script complete.'