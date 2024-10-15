#!/bin/bash

cd backstage && helm dependency update && helm upgrade --install backstage --namespace backstage --create-namespace -f values.yaml .
