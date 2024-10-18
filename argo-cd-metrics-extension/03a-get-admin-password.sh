#!/bin/bash

kubectl get secret -n argo argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
