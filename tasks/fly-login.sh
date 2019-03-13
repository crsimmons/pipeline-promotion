#!/bin/bash

fly --target ci \
  login \
  --insecure \
  --concourse-url "$CONCOURSE_URL" \
  --username "$CONCOURSE_USERNAME" \
  --password "$CONCOURSE_PASSWORD"

fly -t ci sync
