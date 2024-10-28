#!/bin/bash

PROFILE="linux-user-monitoring-with-prometheus-textfile-collector"

minikube start --addons=ingress --cpus=4 --memory=8g --profile=${PROFILE}

minikube profile ${PROFILE}
