#!/bin/bash

helm dependency update

helm upgrade --install prometheus --namespace monitoring --create-namespace -f values.yaml .
