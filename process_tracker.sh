#!/bin/bash
# =============================================
# Linux Process Tracker
# Author: Adarsh Shivan
# =============================================

# Optional argument: sort type (cpu/mem)
SORT_BY=${1:-cpu}

LOG_FILE="process_log_$(date +%F_%H-%M-%S).txt"

echo "🔍 Tracking active system processes..."
echo "==============================================="

# Display current date/time
echo "🕒 Report generated on: $(date)"
echo "-----------------------------------------------"

# Choose sorting criteria
if [[ "$SORT_BY" == "cpu" ]]; then
    echo "Sorting by CPU usage..."
    ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 15
elif [[ "$SORT_BY" == "mem" ]]; then
    echo "Sorting by Memory usage..."
    ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n 15
else
    echo "Invalid sort option! Use: cpu or mem"
    exit 1
fi

# Save report
{
  echo "Process Report - $(date)"
  ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 15
} > "$LOG_FILE"

echo "-----------------------------------------------"
echo "✅ Report saved as: $LOG_FILE"
echo "==============================================="

