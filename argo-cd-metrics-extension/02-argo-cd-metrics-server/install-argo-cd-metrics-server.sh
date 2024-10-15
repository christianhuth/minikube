#!/bin/bash

helm upgrade --install argo-cd-metrics-server --namespace argo --create-namespace -f values.yaml .
