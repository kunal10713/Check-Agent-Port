#!/bin/bash

PortNumber=50051
Connections=$(ss -nlt | grep ":$PortNumber")

if [ -n "$Connections" ]; then
    echo "$Connections" | while read -r line; do
        pid=$(echo "$line" | awk '{print $6}')
        process_name=$(ps -o comm= -p "$pid")
        local_address=$(echo "$line" | awk '{print $4}')
        local_port=$(echo "$local_address" | cut -d: -f2)
        foreign_address=$(echo "$line" | awk '{print $5}')
        foreign_port=$(echo "$foreign_address" | cut -d: -f2)
        state=$(echo "$line" | awk '{print $2}')

        echo "ProcessName      : $process_name"
        echo "PID              : $pid"
        echo "LocalAddress     : $local_address"
        echo "LocalPort        : $local_port"
        echo "ForeignAddress   : $foreign_address"
        echo "ForeignPort      : $foreign_port"
        echo "State            : $state"
        echo
    done
else
    echo "No processes found using port $PortNumber"
fi
 
