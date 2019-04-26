#!/bin/bash
set -e

az account set --subscription DCD-CNP-DEV
az acr task create \
    --registry hmctspublic \
    --name task-idam-base \
    --file acr-build-task.yaml \
    --context https://github.com/hmcts/idam-docker-base.git \
    --branch master \
    --git-access-token $GITHUB_TOKEN