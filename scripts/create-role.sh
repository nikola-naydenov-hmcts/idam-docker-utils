#!/bin/sh

set -e

ID="${1:-citizen}"

apiToken=$(sh /scripts/authenticate.sh "${IDAM_API_URL}" "${IDAM_ADMIN_USER}" "${IDAM_ADMIN_PASSWORD}")

echo -e "\nCreating role with:\nID: ${ID}"

STATUS=$(curl -s -o /dev/null -w '%{http_code}' -H 'Content-Type: application/json' -H "Authorization: AdminApiAuthToken ${apiToken}" \
  ${IDAM_API_URL}/roles -d '{
  "id": "'${ID}'",
  "name": "'${ID}'",
  "description": "'${ID}'",
  "assignableRoles": [ ],
  "conflictingRoles": [ ]
}')

if [ $STATUS -eq 201 ]; then
  echo "Role created sucessfully"
elif [ $STATUS -eq 409 ]; then
  echo "Role already exists!"
else
  echo "ERROR: HTTPCODE = $STATUS"
fi
