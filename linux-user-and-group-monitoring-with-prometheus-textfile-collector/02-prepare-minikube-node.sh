#!/bin/bash



###############
### CRONJOB ###
###############
# update package repository
minikube ssh "sudo apt-get update"

# make sure sponge is available (through moreutils package)
minikube ssh "sudo apt-get install -y moreutils"

# make sure cron is available
minikube ssh "sudo apt-get install -y cron"

# start cron
minikube ssh "sudo systemctl start cron"
