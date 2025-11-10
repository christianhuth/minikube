#!/bin/bash

cd 01-opentelemetry-demo

helm dependency update

helm upgrade --install opentelemetry-demo --namespace default -f values.yaml --wait .

cd ..
