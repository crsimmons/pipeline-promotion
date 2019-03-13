#!/bin/bash
set -ex

if [ ! -z ${FOLLOWS_SPECIFIC_COMMIT} ]; then
  commit=$(bosh int --path /resource_version_pipeline-promotion/ref versions/versions.yml)
  pushd pcf-platform-automation
    git checkout $commit
  popd
fi
set -u

source pipeline-promotion/tasks/fly-login.sh

fly --target ci \
  set-pipeline \
  --pipeline pcf-${FOUNDATION} \
  --config pcf-platform-automation/foundation/pipeline.yml \
  --load-vars-from versions/versions.yml \
  --load-vars-from pcf-platform-automation/foundation-config/${FOUNDATION}_empty_params.yml \
  --var foundation=${FOUNDATION} \
  --non-interactive
