#!/bin/bash



########################
### GENERAL SETTINGS ###
########################
MINIKUBE_NODE="linux-user-monitoring-with-prometheus-textfile-collector"
MINIKUBE_HOME_DIRECTORY="/home/docker"
TEXTFILE_COLLECTOR_REMOTE_DIRECTORY="/var/lib/prometheus-node-exporter/textfile-collector"
TEXTFILE_COLLECTOR_REMOTE_METRICS_DIRECTORY="${TEXTFILE_COLLECTOR_REMOTE_DIRECTORY}/metrics"
TEXTFILE_COLLECTOR_REMOTE_SCRIPTS_DIRECTORY="${TEXTFILE_COLLECTOR_REMOTE_DIRECTORY}/scripts"



##########################
### TEXTFILE COLLECTOR ###
##########################

# make sure textfile collector folders exists on node
minikube ssh "sudo mkdir -p ${TEXTFILE_COLLECTOR_REMOTE_DIRECTORY}"
minikube ssh "sudo mkdir -p ${TEXTFILE_COLLECTOR_REMOTE_METRICS_DIRECTORY}"
minikube ssh "sudo mkdir -p ${TEXTFILE_COLLECTOR_REMOTE_SCRIPTS_DIRECTORY}"



##################################
### TEXTFILE COLLECTOR SCRIPTS ###
##################################
SCRIPT_FILENAME_FOR_LINUX_GROUP_INFO="linux-group-info.sh"
SCRIPT_FILENAME_FOR_LINUX_USER_INFO="linux-user-info.sh"
LOCAL_SCRIPT_DIRECTORY="textfile-collector-scripts"
LOCAL_SCRIPT_PATH_FOR_LINUX_GROUP_INFO="${LOCAL_SCRIPT_DIRECTORY}/${SCRIPT_FILENAME_FOR_LINUX_GROUP_INFO}"
LOCAL_SCRIPT_PATH_FOR_LINUX_USER_INFO="${LOCAL_SCRIPT_DIRECTORY}/${SCRIPT_FILENAME_FOR_LINUX_USER_INFO}"
REMOTE_SCRIPT_PATH_FOR_LINUX_GROUP_INFO=${TEXTFILE_COLLECTOR_REMOTE_SCRIPTS_DIRECTORY}/${SCRIPT_FILENAME_FOR_LINUX_GROUP_INFO}
REMOTE_SCRIPT_PATH_FOR_LINUX_USER_INFO=${TEXTFILE_COLLECTOR_REMOTE_SCRIPTS_DIRECTORY}/${SCRIPT_FILENAME_FOR_LINUX_USER_INFO}

# copy scripts from local directory to minikube node
minikube cp ${LOCAL_SCRIPT_PATH_FOR_LINUX_GROUP_INFO} ${MINIKUBE_NODE}:${MINIKUBE_HOME_DIRECTORY}/${SCRIPT_FILENAME_FOR_LINUX_GROUP_INFO}
minikube cp ${LOCAL_SCRIPT_PATH_FOR_LINUX_USER_INFO} ${MINIKUBE_NODE}:${MINIKUBE_HOME_DIRECTORY}/${SCRIPT_FILENAME_FOR_LINUX_USER_INFO}

# adjust file permissions of metrics script
minikube ssh "sudo chmod 0755 ${MINIKUBE_HOME_DIRECTORY}/*.sh"

# adjust file ownerships of metrics script
minikube ssh "sudo chown root:root ${MINIKUBE_HOME_DIRECTORY}/*.sh"

# move metrics script to textfiles folder
minikube ssh "sudo mv ${MINIKUBE_HOME_DIRECTORY}/*.sh ${TEXTFILE_COLLECTOR_REMOTE_SCRIPTS_DIRECTORY}"



####################
### METRICS FILE ###
####################
PROMETHEUS_METRICS_FILE_FOR_LINUX_GROUP_INFO="${TEXTFILE_COLLECTOR_REMOTE_METRICS_DIRECTORY}/linux_group_info.prom"
PROMETHEUS_METRICS_FILE_FOR_LINUX_USER_INFO="${TEXTFILE_COLLECTOR_REMOTE_METRICS_DIRECTORY}/linux_user_info.prom"

# create metrics file in textfiles folder
minikube ssh "sudo touch ${PROMETHEUS_METRICS_FILE_FOR_LINUX_GROUP_INFO}"
minikube ssh "sudo touch ${PROMETHEUS_METRICS_FILE_FOR_LINUX_USER_INFO}"

# adjust file permissions of metrics file
minikube ssh "sudo chmod 0664 ${TEXTFILE_COLLECTOR_REMOTE_METRICS_DIRECTORY}/*.prom"

# adjust file ownerships of metrics file
minikube ssh "sudo chown root:root ${TEXTFILE_COLLECTOR_REMOTE_METRICS_DIRECTORY}/*.prom"



#####################
### CRONJOB FILES ###
#####################
CRONJOB_DIRECTORY="/etc/cron.d"
CRONJOB_SCHEDULE="*/1 * * * *"
CRONJOB_USER="root"

### LINUX_GROUP_INFO ###
CRONJOB_FILENAME_FOR_LINUX_GROUP_INFO="linux_group_info"
CRONJOB_PATH_FOR_LINUX_GROUP_INFO="${CRONJOB_DIRECTORY}/${CRONJOB_FILENAME_FOR_LINUX_GROUP_INFO}"
CRONJOB_TEMPORARY_PATH_FOR_LINUX_GROUP_INFO="${MINIKUBE_HOME_DIRECTORY}/${CRONJOB_FILENAME_FOR_LINUX_GROUP_INFO}"
CRONJOB_COMMAND_FOR_LINUX_GROUP_INFO="${REMOTE_SCRIPT_PATH_FOR_LINUX_GROUP_INFO} | sponge ${PROMETHEUS_METRICS_FILE_FOR_LINUX_GROUP_INFO} > /dev/null"
CRONJOB_FOR_LINUX_GROUP_INFO="${CRONJOB_SCHEDULE} ${CRONJOB_USER} ${CRONJOB_COMMAND_FOR_LINUX_GROUP_INFO}"

### LINUX_USER_INFO ###
CRONJOB_FILENAME_FOR_LINUX_USER_INFO="linux_user_info"
CRONJOB_PATH_FOR_LINUX_USER_INFO="${CRONJOB_DIRECTORY}/${CRONJOB_FILENAME_FOR_LINUX_USER_INFO}"
CRONJOB_TEMPORARY_PATH_FOR_LINUX_USER_INFO="${MINIKUBE_HOME_DIRECTORY}/${CRONJOB_FILENAME_FOR_LINUX_USER_INFO}"
CRONJOB_COMMAND_FOR_LINUX_USER_INFO="${REMOTE_SCRIPT_PATH_FOR_LINUX_USER_INFO} | sponge ${PROMETHEUS_METRICS_FILE_FOR_LINUX_USER_INFO} > /dev/null"
CRONJOB_FOR_LINUX_USER_INFO="${CRONJOB_SCHEDULE} ${CRONJOB_USER} ${CRONJOB_COMMAND_FOR_LINUX_USER_INFO}"

# create a temporary file that will be used to define the cronjob
minikube ssh "touch ${CRONJOB_TEMPORARY_PATH_FOR_LINUX_GROUP_INFO}"
minikube ssh "touch ${CRONJOB_TEMPORARY_PATH_FOR_LINUX_USER_INFO}"

# add the cronjob definition to the file
minikube ssh "echo \"${CRONJOB_FOR_LINUX_GROUP_INFO}\" > ${CRONJOB_TEMPORARY_PATH_FOR_LINUX_GROUP_INFO}"
minikube ssh "echo \"${CRONJOB_FOR_LINUX_USER_INFO}\" > ${CRONJOB_TEMPORARY_PATH_FOR_LINUX_USER_INFO}"

# move the files to the cronjob directory
minikube ssh "sudo mv ${CRONJOB_TEMPORARY_PATH_FOR_LINUX_GROUP_INFO} ${CRONJOB_PATH_FOR_LINUX_GROUP_INFO}"
minikube ssh "sudo mv ${CRONJOB_TEMPORARY_PATH_FOR_LINUX_USER_INFO} ${CRONJOB_PATH_FOR_LINUX_USER_INFO}"

# adjust file ownerships of cron file
minikube ssh "sudo chown ${CRONJOB_USER}:${CRONJOB_USER} ${CRONJOB_PATH_FOR_LINUX_GROUP_INFO}"
minikube ssh "sudo chown ${CRONJOB_USER}:${CRONJOB_USER} ${CRONJOB_PATH_FOR_LINUX_USER_INFO}"
