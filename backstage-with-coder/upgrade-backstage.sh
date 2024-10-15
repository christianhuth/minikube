#!/bin/bash

cd backstage && helm upgrade --install backstage --namespace backstage --create-namespace -f values.yaml .
