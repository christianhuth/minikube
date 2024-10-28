# Linux User and Group Monitoring with Prometheus Textfile Collector

This small demo project shows how to export information about Linux users and groups into Prometheus using the Textfile Collector and custom scripts.

## Start a Minikube Cluster (optional)

```bash
./00-start-minikube.sh
```

## Install Prometheus

```bash
./01-install-prometheus.sh
```

## Prepare the Minikube Node

```bash
./02-prepare-minikube-node.sh
```

## Setup Textfile Collector on the Minikube Node

```bash
./03-setup-textfile-collector.sh
```

## Access Prometheus UI

```bash
minikube tunnel
```

Open [https://prometheus.127.0.0.1.nip.io](https://prometheus.127.0.0.1.nip.io/graph?g0.expr=linux_user_info%7B%7D&g0.tab=1&g0.display_mode=lines&g0.show_exemplars=0&g0.range_input=1h) in your Browser and you should already see the new metrics `linux_user_info{}` and `linux_group_info{}`.
