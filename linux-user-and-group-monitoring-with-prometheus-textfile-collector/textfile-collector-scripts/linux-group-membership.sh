#!/bin/bash

set -eo pipefail

GROUPFILE="/etc/group"

while IFS=':' read -r groupname password groupId users; do
    if [ ! -z "${users}" ];
    then
        IFS=',' read -r -a array <<< "$users"
        for element in "${array[@]}"
        do
            echo "linux_group_membership{groupname=\"$groupname\",gid=\"$groupId\",username=\"${element}\"} 1"
        done
    fi
done < "${GROUPFILE}"
