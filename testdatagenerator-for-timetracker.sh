#!/bin/bash
# GitHub Copilot ChatGPT 4o
# and
# Rich W.
# 11/25/2024
# license: MSL.l

# Wow, that is pretty great.
# There are a few improvements I would like to make, 
# but first I want to test it a little.
# Can you generate 250 lines of test data for me?

DATA_FILE="timetracker_data.txt"

# Clear the file if it exists
> $DATA_FILE

# Generate test data
for i in {1..50}; do
    echo "TASK: Task_$i" >> $DATA_FILE
    for j in {1..5}; do
        start_time=$(( $(date +%s) - RANDOM % 100000 ))
        stop_time=$(( start_time + RANDOM % 3600 ))
        echo "START: Task_$i $start_time" >> $DATA_FILE
        echo "STOP: Task_$i $stop_time" >> $DATA_FILE
        echo "NOTES: Task_$i Note_$j" >> $DATA_FILE
    done
done

echo "Generated 250 lines of test data in $DATA_FILE"