#!/bin/bash
# GitHub Copilot ChatGPT 4o
# and
# Rich W.
# 11/25/2024
# license: MSL.l


echo "NOT TESTED"
exit 0

# input to GPT 4o 11/25/2024 (with newline reformatting for inclusion here):
# I would like a bash script that is a menu-driven interface for tracking work time.
# It should have options to 1) take text input for a task name,
# 2) timestamp starting work on a work task,
# 3) timestamp stopping work on a work task, 
# 4) taking text input as notes for a task, 
# 5) displaying a total of the time worked on a task, 
# 6) displaying the total time worked on a task for a certain day with recorded work,
# 7) displaying the timestamp records for a work task, and 
# 8) outputting the data as JSON format.  The script should use a simple text file to record timestamps.

DATA_FILE="timetracker_data.txt"

function menu() {
    echo "1) Start a new task"
    echo "2) Start work on a task"
    echo "3) Stop work on a task"
    echo "4) Add notes to a task"
    echo "5) Display total time worked on a task"
    echo "6) Display total time worked on a task for a day"
    echo "7) Display timestamp records for a task"
    echo "8) Output data as JSON"
    echo "9) Mark task as inactive"
    echo "10) Show active tasks"
    echo "11) Show inactive tasks"
    echo "12) Show all tasks"
    echo "13) Show in-progress tasks"
    echo "14) Exit"
    read -p "Choose an option: " choice
    case $choice in
        1) start_new_task ;;
        2) start_work ;;
        3) stop_work ;;
        4) add_notes ;;
        5) display_total_time ;;
        6) display_total_time_day ;;
        7) display_timestamps ;;
        8) output_json ;;
        9) mark_task_inactive ;;
        10) show_active_tasks ;;
        11) show_inactive_tasks ;;
        12) show_all_tasks ;;
        13) show_in_progress_tasks ;;
        14) exit 0 ;;
        *) echo "Invalid option" ;;
    esac
}

function start_new_task() {
    read -p "Enter task name: " task_name
    read -p "Enter category (optional): " category
    read -p "Enter tags (comma-separated, optional): " tags
    echo "TASK: $task_name | CATEGORY: $category | TAGS: $tags | ACTIVE: true" >> $DATA_FILE
    echo "START: $task_name $(date +%s)" >> $DATA_FILE
    echo "Task '$task_name' created and started."
}

function start_work() {
    read -p "Enter task name: " task_name
    echo "START: $task_name $(date +%s)" >> $DATA_FILE
    echo "Started work on task '$task_name'."
}

function stop_work() {
    read -p "Enter task name: " task_name
    echo "STOP: $task_name $(date +%s)" >> $DATA_FILE
    echo "Stopped work on task '$task_name'."
}

function add_notes() {
    read -p "Enter task name: " task_name
    read -p "Enter notes: " notes
    echo "NOTES: $task_name $notes" >> $DATA_FILE
    echo "Notes added to task '$task_name'."
}

function display_total_time() {
    read -p "Enter task name: " task_name
    total_time=0
    start_time=0
    while read -r line; do
        if [[ $line == START:* && $line == *"$task_name"* ]]; then
            start_time=$(echo $line | awk '{print $3}')
        elif [[ $line == STOP:* && $line == *"$task_name"* ]]; then
            stop_time=$(echo $line | awk '{print $3}')
            total_time=$((total_time + stop_time - start_time))
        fi
    done < $DATA_FILE
    echo "Total time worked on task '$task_name': $((total_time / 60)) minutes"
}

function display_total_time_day() {
    read -p "Enter task name: " task_name
    read -p "Enter date (YYYY-MM-DD): " date
    total_time=0
    start_time=0
    while read -r line; do
        if [[ $line == START:* && $line == *"$task_name"* && $line == *"$date"* ]]; then
            start_time=$(echo $line | awk '{print $3}')
        elif [[ $line == STOP:* && $line == *"$task_name"* && $line == *"$date"* ]]; then
            stop_time=$(echo $line | awk '{print $3}')
            total_time=$((total_time + stop_time - start_time))
        fi
    done < $DATA_FILE
    echo "Total time worked on task '$task_name' on $date: $((total_time / 60)) minutes"
}

function display_timestamps() {
    read -p "Enter task name: " task_name
    grep "$task_name" $DATA_FILE
}

function output_json() {
    read -p "Enter output filename (default: output.json): " filename
    filename=${filename:-output.json}
    echo "[" > $filename
    while read -r line; do
        if [[ $line == TASK:* ]]; then
            task_name=$(echo $line | awk -F'|' '{print $1}' | awk '{print $2}')
            category=$(echo $line | awk -F'|' '{print $2}' | awk '{print $2}')
            tags=$(echo $line | awk -F'|' '{print $3}' | awk '{print $2}')
            active=$(echo $line | awk -F'|' '{print $4}' | awk '{print $2}')
            echo "  {" >> $filename
            echo "    \"task\": \"$task_name\"," >> $filename
            echo "    \"category\": \"$category\"," >> $filename
            echo "    \"tags\": \"$tags\"," >> $filename
            echo "    \"active\": \"$active\"," >> $filename
            echo "    \"records\": [" >> $filename
        elif [[ $line == START:* || $line == STOP:* || $line == NOTES:* ]]; then
            record=$(echo $line | awk '{print substr($0, index($0,$2))}')
            echo "      \"$record\"," >> $filename
        fi
    done < $DATA_FILE
    echo "    ]" >> $filename
    echo "  }" >> $filename
    echo "]" >> $filename
    echo "Data output to $filename"
}

function mark_task_inactive() {
    read -p "Enter task name: " task_name
    sed -i "/TASK: $task_name/ s/ACTIVE: true/ACTIVE: false/" $DATA_FILE
    echo "Task '$task_name' marked as inactive."
}

function show_active_tasks() {
    grep "ACTIVE: true" $DATA_FILE | awk -F'|' '{print $1}' | awk '{print $2}'
}

function show_inactive_tasks() {
    grep "ACTIVE: false" $DATA_FILE | awk -F'|' '{print $1}' | awk '{print $2}'
}

function show_all_tasks() {
    grep "TASK:" $DATA_FILE | awk -F'|' '{print $1}' | awk '{print $2}'
}

function show_in_progress_tasks() {
    grep "START:" $DATA_FILE | awk '{print $2}' | sort | uniq
}

while true; do
    menu
done
