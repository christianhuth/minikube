#!/bin/bash

minikube start --addons=ingress --cpus=4 --memory=8g --profile=kubevirt-demo --kubernetes-version=v1.30.1

minikube profile kubevirt-demo
