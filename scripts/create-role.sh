#!/bin/sh

set -e

ENV="${1:-local}"
ID="${2:-citizen}"

case ${ENV} in
  local)
    IDAM_URI="http://idam-api:5000"
    IDAM_USER="idamowner%40hmcts.net"
    IDAM_PW="Ref0rmIsFun"
  ;;
  *)
    echo ${ENV_MESSAGE}
    exit 1 ;;
esac

apiToken=$(sh /scripts/authenticate.sh "${IDAM_URI}" "${IDAM_USER}" "${IDAM_PW}")

echo -e "\nCreating role with:\nID: ${ID}"

curl --silent --show-error -H 'Content-Type: application/json' -H "Authorization: AdminApiAuthToken ${apiToken}" \
  ${IDAM_URI}/roles -d '{
  "id": "'${ID}'",
  "name": "'${ID}'",
  "description": "'${ID}'",
  "assignableRoles": [ ],
  "conflictingRoles": [ ]
}'
