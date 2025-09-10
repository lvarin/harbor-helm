#!/bin/bash
#

DIRNAME=$(dirname $0)

USER=admin
PASS=$(yq .harborAdminPassword $DIRNAME/../values.yaml -r)

AUTH=$(echo -n "$USER:$PASS" | base64)

curl -X 'PUT' \
  'https://satama-test.csc.fi/api/v2.0/configurations' \
  -H 'Content-Type: application/json' \
  -H "authorization: Basic $AUTH" \
  -w "satama-test: %{http_code}\n" \
  -d@satama-test.oidc.yaml

curl -X 'PUT' \
  'https://satama-test.csc.fi/api/v2.0/configurations' \
  -H 'Content-Type: application/json' \
  -H "authorization: Basic $AUTH" \
  -w "satama: %{http_code}\n" \
  -d@satama.oidc.yaml

