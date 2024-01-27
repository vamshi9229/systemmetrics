#!/bin/bash

CPU_THRESHOLD=70
MEMORY_THRESHOLD=80
DISK_THRESHOLD=90
SERVICE_NAME="ssh"
LOG_FILE="/var/log/syslog"

# Get system metrics
CPU_USAGE=$(top -b -n 1 | grep '%Cpu(s)' | awk '{print $2}' | cut -d. -f1)
MEMORY_USAGE=$(free | awk '/Mem/{printf "%.0f", $3/$2 * 100}')
DISK_USAGE=$(df -h / | awk '/\//{print $5}' | cut -d% -f1)

# Check CPU usage
if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "High CPU Usage: $CPU_USAGE%" >> "$LOG_FILE"
fi

# Check memory usage
if [ "$MEMORY_USAGE" -gt "$MEMORY_THRESHOLD" ]; then
    echo "High Memory Usage: $MEMORY_USAGE%" >> "$LOG_FILE"
fi
