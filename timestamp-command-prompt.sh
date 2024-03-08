#!/bin/bash

#Rich W.
#MSL.l

# temporarily change the command prompt to include a timestamp

newpromptstring="\H\D{%m/%d/%y}::\T $ "
export PS1="\H#\D{%m/%d/%y}::\T $ "

echo "Timestamp command prompt set to '$newpromptstring'."

bash

echo "'timestamp-command-prompt.sh' completed."