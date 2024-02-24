#!/bin/bash

#Feb. 2024
#
#Rich W.
#with
#GitHub Copilot
#
#license under MSL.l


# Run all python files in the current directory

python_executable=""
if command -v python3 &> /dev/null; then
    python_executable="python3"
elif command -v python &> /dev/null; then
    python_executable="python"
else
    echo "Python executable not found"
    exit 1
fi

if [[ "$1" != "--I-am-sure" ]]; then
    echo "This script will run all python files in the current directory."
    echo "Please provide the '--I-am-sure' argument to run this script."
    exit 1
fi

for file in $(ls *.py | sort); do
    if [[ -f $file ]]; then
        echo ""
        echo "----------------------------------------"
        echo "Running $file"
        echo "----------------------------------------"
        "$python_executable" "$file"
        echo "----------------------------------------"
        echo "$file completed"
        echo "----------------------------------------"
        echo ""
    fi
done
