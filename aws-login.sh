#!/bin/bash
export MFA_ARN=#add your mfa arn here
export AWS_PROFILE=msgcxp
export TOKEN=$(aws sts get-session-token --serial-number $MFA_ARN --token-code $1)
export ACCESS_KEY=$(echo $TOKEN | jq .Credentials.AccessKeyId)
export SECRET_ACCESS_KEY=$(echo $TOKEN | jq .Credentials.SecretAccessKey)
export SESSION_TOKEN=$(echo $TOKEN | jq .Credentials.SessionToken)
aws configure --profile msgcxp-sts set aws_access_key_id $ACCESS_KEY
aws configure --profile msgcxp-sts set aws_secret_access_key $SECRET_ACCESS_KEY
aws configure --profile msgcxp-sts set aws_session_token $SESSION_TOKEN
