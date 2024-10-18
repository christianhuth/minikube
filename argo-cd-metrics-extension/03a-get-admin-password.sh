#!/bin/bash

ADMIN_PASSWORD=$(kubectl get secret -n argo argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo ""
echo "You can login into the Argo CD UI using the following credentials:"
echo "Username: admin"
echo "Password: $ADMIN_PASSWORD"
echo ""
