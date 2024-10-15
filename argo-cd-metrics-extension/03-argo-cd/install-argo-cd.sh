#!/bin/bash

helm dependency update

helm upgrade --install argo-cd --namespace argo --create-namespace -f values.yaml .
