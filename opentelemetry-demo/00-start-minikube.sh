#!/bin/bash

minikube start --nodes 2 --addons=ingress --cpus=6 --kubernetes-version=v1.32.0 --memory=12g --profile=opentelemetry-demo

minikube profile opentelemetry-demo
