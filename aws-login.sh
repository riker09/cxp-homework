#!/bin/bash
# add your mfa arn and default profile to .envrc
source .envrc
export TOKEN=$(aws sts get-session-token --serial-number $MFA_ARN --token-code $1)
export ACCESS_KEY=$(echo $TOKEN | jq .Credentials.AccessKeyId | sed -e 's/"//g')
export SECRET_ACCESS_KEY=$(echo $TOKEN | jq .Credentials.SecretAccessKey | sed -e 's/"//g')
export SESSION_TOKEN=$(echo $TOKEN | jq .Credentials.SessionToken | sed -e 's/"//g')

aws configure --profile msgcxp-sts set aws_access_key_id $ACCESS_KEY
aws configure --profile msgcxp-sts set aws_secret_access_key $SECRET_ACCESS_KEY
aws configure --profile msgcxp-sts set aws_session_token $SESSION_TOKEN
