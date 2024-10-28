#!/bin/bash

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install kube-prometheus-stack --namespace monitoring --create-namespace -f 01-values.yaml --wait prometheus-community/kube-prometheus-stack
