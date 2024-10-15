#!/bin/bash

helm dependency update

helm upgrade --install kube-prometheus-stack --namespace monitoring --create-namespace -f values.yaml .
