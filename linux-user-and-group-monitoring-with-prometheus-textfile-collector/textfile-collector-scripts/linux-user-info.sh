#!/bin/bash

set -eo pipefail

USERFILE="/etc/passwd"

while IFS=':' read -r username encryptedPasswordInShadowFile userId groupId userIdInfo homeDirectory shell; do
    echo "linux_user_info{username=\"$username\",uid=\"$userId\",gid=\"$groupId\",home=\"$homeDirectory\",shell=\"$shell\"} 1"
done < "${USERFILE}"
