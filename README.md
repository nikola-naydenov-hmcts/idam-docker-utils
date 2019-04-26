# idam-docker-base

Docker image with some IDAM helper scripts baked in. To be used as a base for custom IDAM images. Motivation for this repo driven from requirement to setup local dev environments using new IDAM Docker images.

## Building

Dockerhub (https://cloud.docker.com/u/hmcts/repository/docker/hmcts/feature-toggle-importer) is deprecated - please use ACR.

Any commit or merge into master will automatically trigger an Azure ACR task. This task has been manually
created using `./bin/deploy-acr-task.sh`. The task is defined in `acr-build-task.yaml`. 

Note: you will need a GitHub personal token defined in `GITHUB_TOKEN` environment variable to run deploy script (https://help.github.com/en/articles/creating-a-personal-access-token-for-the-command-line). The token is for setting up a webhook so Azure will be notified when a merge or commit happens. Make sure you are a repo admin and select token scope of: `admin:repo_hook  Full control of repository hooks`

More info on ACR tasks can be read here: https://docs.microsoft.com/en-us/azure/container-registry/container-registry-tasks-overview

## Using

Example Dockerfile built on top of this base:

```
FROM hmcts.azurecr.io/hmctspublic/idam-base

COPY scripts /scripts

RUN chmod +x /scripts/*.sh
```

Include any custom initialisation in scripts directory and a `setup.sh` (called from base default CMD).

## Working Example

https://github.com/hmcts/cmc-integration-tests/tree/master/docker/idam-importer