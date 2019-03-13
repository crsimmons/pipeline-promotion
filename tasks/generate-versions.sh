#!/bin/bash

dirname=$(dirname $0)

$dirname/fly-login.sh

export ATC_BEARER_TOKEN=$(bosh int --path /targets/ci/token/value ~/.flyrc)

PIPELINE_NAME=$(<build-metadata/build-pipeline-name)

team=$(cat build-metadata/build-team-name)
job=$(cat build-metadata/build-job-name)

stopover ${CONCOURSE_URL} $team ${PIPELINE_NAME} $job $(cat build-metadata/build-name) > resource-versions/versions.yml
