#!/bin/sh

set -e

ENV="${1:-local}"
LABEL="${2:-citizen}"
SELF_REG="${3:-true}"
CLIENT_ID="${4:-cmc_citizen}"
CLIENT_SECRET="${5:-12345678}"
REDIRECT_URLS="${6:-'["https://localhost:3000/receiver"]'}"
ALLOWED_ROLES="${7:-'["citizen"]'}"

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

echo -e "\nCreating service with:\nLabel: ${LABEL}\nClient ID: ${CLIENT_ID}\nClient Secret: ${CLIENT_SECRET}\nRedirect URL: ${REDIRECT_URLS}\nRoles: ${ALLOWED_ROLES}"

curl --silent --show-error -H 'Content-Type: application/json' -H "Authorization: AdminApiAuthToken ${apiToken}" \
  ${IDAM_URI}/services -d '{
  "description": "Money Claims - '${LABEL}'",
  "label": "Money Claims - '${LABEL}'",
  "oauth2ClientId": "'${CLIENT_ID}'",
  "oauth2ClientSecret": "'${CLIENT_SECRET}'",
  "oauth2Scope": "openid profile authorities acr roles",
  "oauth2RedirectUris": '${REDIRECT_URLS}',
  "activationRedirectUrl": "",
  "allowedRoles": '${ALLOWED_ROLES}',
  "onboardingEndpoint": "",
  "onboardingRoles": [ ],
  "selfRegistrationAllowed": '${SELF_REG}'
}'
