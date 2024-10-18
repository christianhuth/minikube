#!/bin/bash

kubectl create ns argo

kubectl apply -f 02-argo-cd-metrics-server

kubectl rollout status deployment argo-cd-metrics-server
