#!/bin/bash
set -e

az account set --subscription DCD-CNP-DEV
az acr task delete -r hmctsublic -n task-idam-utils