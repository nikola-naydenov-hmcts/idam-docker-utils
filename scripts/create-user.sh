#!/bin/sh

set -e

USER_EMAIL="${1:-me@server.net}"
FORENAME="${2:-John}"
SURNAME="${3:-Smith}"
PASSWORD="${4:-Password12}"
USER_GROUP="${5:-cmc-private-beta}"
USER_ROLES="${6:-[]}"

echo -e "\nCreating user with:\nUsername: ${USER_EMAIL}\nPassword: ${PASSWORD}\nFirstname: ${FORENAME}\nSurname: ${SURNAME}\nUser group: ${USER_GROUP}\nRoles: ${USER_ROLES}"

STATUS=$(curl -s -o /dev/null -w '%{http_code}' -XPOST -H 'Content-Type: application/json' ${IDAM_API_URL}/testing-support/accounts -d '{
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
}')

if [ $STATUS -eq 201 ]; then
  echo "User created sucessfully"
elif [ $STATUS -eq 409 ]; then
  echo "User already exists!"
else
  echo "ERROR: HTTPCODE = $STATUS"
fi
