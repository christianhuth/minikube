#!/bin/bash

cd 01-kube-prometheus-stack

helm dependency update

helm upgrade --install kube-prometheus-stack --namespace monitoring --create-namespace -f values.yaml --wait .

cd ..
