#!/bin/bash

# ==========================================
# Linux Server Monitoring
# ==========================================

LOG_FILE="$HOME/intelligent-linux-server-monitoring/server_monitor.log"

# Email address that receives alerts
ALERT_EMAIL="${ALERT_EMAIL:-}"

# Send output to terminal AND log file
exec > >(tee -a "$LOG_FILE") 2>&1

echo ""
echo "=========================================="
echo "        Linux Server Monitoring"
echo "=========================================="

# ------------------------------------------
# Server Information
# ------------------------------------------

HOSTNAME=$(hostname)
CURRENT_DATE=$(date)
UPTIME=$(uptime -p)

echo "Hostname: $HOSTNAME"
echo "Date: $CURRENT_DATE"
echo "Uptime: $UPTIME"

# ------------------------------------------
# CPU Monitoring
# ------------------------------------------

CPU_IDLE=$(top -bn1 | grep "Cpu" | awk '{print $8}')

CPU_USAGE=$(awk "BEGIN {printf \"%.1f\", 100 - $CPU_IDLE}")

echo "CPU Usage: ${CPU_USAGE}%"

CPU_INT=${CPU_USAGE%.*}

CPU_THRESHOLD=80

if [ "$CPU_INT" -gt "$CPU_THRESHOLD" ]; then

    echo "WARNING: High CPU usage detected!"

    echo "Sending CPU alert email..."

    mail -s "SERVER ALERT - High CPU Usage" "$ALERT_EMAIL" <<EOF
Linux Server Monitoring Alert

Server: $HOSTNAME
Alert: High CPU Usage

CPU Usage: ${CPU_USAGE}%
Threshold: ${CPU_THRESHOLD}%

Date: $CURRENT_DATE
Uptime: $UPTIME

Please check the server immediately.
EOF

else

    echo "CPU Status: NORMAL"

fi

# ------------------------------------------
# Memory Monitoring
# ------------------------------------------

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.1f", ($3/$2)*100}')

echo "Memory Usage: ${MEMORY_USAGE}%"

MEMORY_INT=${MEMORY_USAGE%.*}

MEMORY_THRESHOLD=80

if [ "$MEMORY_INT" -gt "$MEMORY_THRESHOLD" ]; then

    echo "WARNING: High memory usage detected!"

    echo "Sending memory alert email..."

    mail -s "SERVER ALERT - High Memory Usage" "$ALERT_EMAIL" <<EOF
Linux Server Monitoring Alert

Server: $HOSTNAME
Alert: High Memory Usage

Memory Usage: ${MEMORY_USAGE}%
Threshold: ${MEMORY_THRESHOLD}%

Date: $CURRENT_DATE
Uptime: $UPTIME

Please check the server immediately.
EOF

else

    echo "Memory Status: NORMAL"

fi

# ------------------------------------------
# Disk Monitoring
# ------------------------------------------

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')

echo "Disk Usage: ${DISK_USAGE}%"

DISK_THRESHOLD=80

if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then

    echo "WARNING: High disk usage detected!"

    echo "Sending disk alert email..."

    mail -s "SERVER ALERT - High Disk Usage" "$ALERT_EMAIL" <<EOF
Linux Server Monitoring Alert

Server: $HOSTNAME
Alert: High Disk Usage

Disk Usage: ${DISK_USAGE}%
Threshold: ${DISK_THRESHOLD}%

Date: $CURRENT_DATE
Uptime: $UPTIME

Please check the server immediately.
EOF

else

    echo "Disk Status: NORMAL"

fi

# ------------------------------------------
# Network Monitoring
# ------------------------------------------

echo "Checking Network Connectivity..."

if ping -c 1 8.8.8.8 > /dev/null 2>&1; then

    echo "Network Status: CONNECTED"

else

    echo "WARNING: Network connection failed!"

    echo "Sending network alert email..."

    mail -s "SERVER ALERT - Network Failure" "$ALERT_EMAIL" <<EOF
Linux Server Monitoring Alert

Server: $HOSTNAME
Alert: Network Connection Failed

The server could not reach 8.8.8.8.

Date: $CURRENT_DATE
Uptime: $UPTIME

Please check the network connection.
EOF

fi

# ------------------------------------------
# Service Monitoring
# ------------------------------------------

SERVICE="crond"

if systemctl is-active --quiet "$SERVICE"; then

    echo "$SERVICE Service: RUNNING"

else

    echo "WARNING: $SERVICE Service is NOT running!"

    echo "Sending service alert email..."

    mail -s "SERVER ALERT - Service Down" "$ALERT_EMAIL" <<EOF
Linux Server Monitoring Alert

Server: $HOSTNAME
Alert: Service Down

Service: $SERVICE
Status: NOT RUNNING

Date: $CURRENT_DATE
Uptime: $UPTIME

Please check the service immediately.
EOF

fi

# ------------------------------------------
# Monitoring Completed
# ------------------------------------------

echo "=========================================="
echo "Monitoring completed."
echo "Log file: $LOG_FILE"
echo "=========================================="
