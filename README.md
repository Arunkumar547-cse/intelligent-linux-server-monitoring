# Intelligent Linux Server Monitoring

A Linux server monitoring project using Bash scripting, Prometheus, and Grafana to monitor system resource usage and visualize server performance.

## Project Overview

This project monitors essential Linux server metrics and provides a Grafana dashboard for viewing CPU, memory, and disk utilization. The Bash monitoring script also supports threshold-based alerts and scheduled execution using Cron.

## Features

- CPU utilization monitoring
- Memory utilization monitoring
- Disk utilization monitoring
- Network connectivity checks
- System service monitoring
- Email alerts for detected issues
- Cron-based scheduled monitoring
- Log-based monitoring history
- Grafana dashboard with Prometheus queries
- Configurable resource thresholds

## Technologies Used

- CentOS Stream 10
- Bash Shell Scripting
- Prometheus
- Grafana
- Node Exporter
- Cron
- Postfix and Gmail SMTP
- Git and GitHub

## Project Structure

```text
intelligent-linux-server-monitoring/
├── monitor.sh
├── README.md
├── .gitignore
└── grafana-dashboard.json
```

## Setup

1. Clone this repository.
2. Ensure Bash and the required Linux monitoring utilities are installed.
3. Configure the email recipient and mail delivery settings if email alerts are required.
4. Configure Prometheus to scrape Node Exporter metrics from the Linux server.
5. Import `grafana-dashboard.json` into Grafana and select the appropriate Prometheus data source.
6. Run the monitoring script:

   ```bash
   chmod +x monitor.sh
   ./monitor.sh
   ```

7. To schedule monitoring every five minutes, configure a Cron entry using the correct absolute path to `monitor.sh`.

## Grafana Dashboard

The included dashboard JSON defines panels for:

- CPU usage percentage
- Memory usage percentage
- Root filesystem disk usage percentage

The dashboard uses Prometheus metrics from Node Exporter. Update the Prometheus data source and scrape configuration to match your environment.

## Security Notes

- Do not commit passwords, SMTP credentials, private keys, or other secrets.
- Configure email credentials securely on the host.
- Review `.gitignore` before committing files.

## Project Goal

To demonstrate practical Linux administration, shell scripting, server monitoring, alerting, metrics collection, and dashboard visualization skills relevant to Cloud Support and Junior DevOps roles.
