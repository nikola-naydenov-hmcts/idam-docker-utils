#!/bin/sh

set -e

LABEL="${1:-citizen}"
SELF_REG="${2:-true}"
CLIENT_ID="${3:-cmc_citizen}"
CLIENT_SECRET="${4:-12345678}"
REDIRECT_URLS="${5:-'["https://localhost:3000/receiver"]'}"
ALLOWED_ROLES="${6:-'["citizen"]'}"

apiToken=$(sh /scripts/authenticate.sh "${IDAM_API_URL}" "${IDAM_ADMIN_USER}" "${IDAM_ADMIN_PASSWORD}")

echo -e "\nCreating service with:\nLabel: ${LABEL}\nClient ID: ${CLIENT_ID}\nClient Secret: ${CLIENT_SECRET}\nRedirect URL: ${REDIRECT_URLS}\nRoles: ${ALLOWED_ROLES}"

STATUS=$(curl -s -o /dev/null -w '%{http_code}' -H 'Content-Type: application/json' -H "Authorization: AdminApiAuthToken ${apiToken}" \
  ${IDAM_API_URL}/services -d '{
  "description": "'${LABEL}'",
  "label": "'${LABEL}'",
  "oauth2ClientId": "'${CLIENT_ID}'",
  "oauth2ClientSecret": "'${CLIENT_SECRET}'",
  "oauth2Scope": "openid profile authorities acr roles",
  "oauth2RedirectUris": '${REDIRECT_URLS}',
  "activationRedirectUrl": "",
  "allowedRoles": '${ALLOWED_ROLES}',
  "onboardingEndpoint": "",
  "onboardingRoles": [ ],
  "selfRegistrationAllowed": '${SELF_REG}'
}')

if [ $STATUS -eq 201 ]; then
  echo "Service created sucessfully"
elif [ $STATUS -eq 409 ]; then
  echo "Service already exists!"
else
  echo "ERROR: HTTPCODE = $STATUS"
fi
