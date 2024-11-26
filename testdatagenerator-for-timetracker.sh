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

# That is not exactly what I wanted, but better enough.
# Can you have the script start with the current date time,
# then have each sequential timestamp a random number of 
# minutes and seconds later after the last timestamp date time?


DATA_FILE="timetracker_data.txt"

# Clear the file if it exists
> $DATA_FILE

# Start time as the current date and time
current_time=$(date +%s)

# Generate test data
for i in {1..50}; do
    echo "TASK: Task_$i" >> $DATA_FILE
    for j in {1..5}; do
        start_time=$current_time
        # Randomly add between 1 to 30 minutes and 0 to 59 seconds
        random_increment=$(( RANDOM % 1800 + 60 ))
        stop_time=$(( start_time + random_increment ))
        echo "START: Task_$i $start_time" >> $DATA_FILE
        echo "STOP: Task_$i $stop_time" >> $DATA_FILE
        echo "NOTES: Task_$i Note_$j" >> $DATA_FILE
        # Update current_time to the stop_time for the next iteration
        current_time=$stop_time
    done
done

echo "Generated 250 lines of test data in $DATA_FILE"