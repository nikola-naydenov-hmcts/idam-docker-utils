#!/bin/sh

set -e

USER_EMAIL="${1:-me@server.net}"
ENV="${2:-local}"
FORENAME="${3:-John}"
SURNAME="${4:-Smith}"
PASSWORD=Password12
USER_GROUP="${5:-cmc-private-beta}"
USER_ROLES="${6:-[]}"

case ${ENV} in
  local)
    IDAM_URI="http://idam-api:5000"
  ;;
  *)
    echo ${ENV_MESSAGE}
    exit 1 ;;
esac

echo -e "\nCreating user with:\nUsername: ${USER_EMAIL}\nPassword: ${PASSWORD}\nFirstname: ${FORENAME}\nSurname: ${SURNAME}\nUser group: ${USER_GROUP}\nRoles: ${USER_ROLES}"

curl --silent --show-error -XPOST -H 'Content-Type: application/json' ${IDAM_URI}/testing-support/accounts -d '{
    "email": "'${USER_EMAIL}'",
    "forename": "'${FORENAME}'",
    "surname": "'${SURNAME}'",
    "levelOfAccess": 0,
    "userGroup": {
      "code": "'${USER_GROUP}'"
    },
    "activationDate": "",
    "lastAccess": "",
    "roles": '${USER_ROLES}',
    "password": "'${PASSWORD}'"
}'
