#!/bin/sh

set -e

LABEL="${1:-citizen}"
OPERATION="${2:-add}"
FIELD="${3:-redirect_uri}"
VALUE="${4:-'["https://localhost:3000/receiver"]'}"

echo -e "\nService patch for:\nLabel: ${LABEL}\nOPERATION: ${OPERATION}\nFIELD: ${FIELD}\nVALUE: ${VALUE}"

STATUS=$(curl -X PATCH -s -o /dev/null -w '%{http_code}' -H 'Content-Type: application/json' \
  ${IDAM_API_URL}/testing-support/services/${LABEL} -d '[{
  "operation": "'${OPERATION}'",
  "field": "'${FIELD}'",
  "value": "'${VALUE}'"
}]')

if [ $STATUS -eq 204 ]; then
  echo "Service patched sucessfully"
else
  echo "ERROR: HTTPCODE = $STATUS"
  exit 1
fi
