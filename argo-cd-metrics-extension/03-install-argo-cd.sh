#!/bin/bash

cd 03-argo-cd

helm dependency update

helm upgrade --install argo-cd --namespace argo --create-namespace -f values.yaml --wait .

cd ..

./03a-get-admin-password.sh
