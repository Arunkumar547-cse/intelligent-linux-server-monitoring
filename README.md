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

_IP:9100"]
```## Grafana Dashboard
## Prometheus and Node Exporter Configuration

Prometheus collects Linux server metrics through Node Exporter.

Configure the Node Exporter target in your Prometheus configuration file (`prometheus.yml`) using your server's reachable IP address:

```yaml
scrape_configs:
  - job_name: "centos-linux"
    static_configs:
      - targets: ["YOUR_SERVER_IP:9100"]
```

**Important:** Replace `YOUR_SERVER_IP` with the actual IP address or hostname of the Linux server running Node Exporter before starting or reloading Prometheus. Do not use the placeholder literally in your active configuration.

If Node Exporter runs on the same machine as Prometheus, you can use `localhost:9100`. If they run on separate machines, use the reachable IP address of the Node Exporter server.

## Grafana Dashboard

The included `grafana-dashboard.json` defines panels for:

- CPU usage percentage
- Memory usage percentage
- Root filesystem disk usage percentage

To use the dashboard:

1. Open Grafana.
2. Add or select your Prometheus data source.
3. Import `grafana-dashboard.json`.
4. Verify that the dashboard queries match your Prometheus metrics and scrape job configuration.

Update the Prometheus data source and scrape configuration to match your environment.

## Project Goal

To demonstrate practical Linux administration, shell scripting, server monitoring, alerting, metrics collection, and dashboard visualization skills relevant to Cloud Support and Junior DevOps roles.
