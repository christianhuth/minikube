#!/bin/bash

set -eo pipefail

GROUPFILE="/etc/group"

while IFS=':' read -r groupname password groupId users; do
    echo "linux_group_info{groupname=\"$groupname\",gid=\"$groupId\"} 1"
done < "${GROUPFILE}"
