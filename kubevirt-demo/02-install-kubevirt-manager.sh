#!/bin/bash

cd 02-kubevirt-manager

helm dependency update

helm upgrade --install kubevirt-manager --namespace kubevirt -f values.yaml --wait .

cd ..
