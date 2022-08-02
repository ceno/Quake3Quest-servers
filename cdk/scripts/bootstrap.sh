#!/bin/bash

AWS_ACCOUNT_ID="$1"

npx aws-cdk bootstrap aws://${AWS_ACCOUNT_ID}/ca-central-1
npx aws-cdk bootstrap aws://${AWS_ACCOUNT_ID}/us-west-1
npx aws-cdk bootstrap aws://${AWS_ACCOUNT_ID}/ap-southeast-2
npx aws-cdk bootstrap aws://${AWS_ACCOUNT_ID}/us-east-1
npx aws-cdk bootstrap aws://${AWS_ACCOUNT_ID}/ap-northeast-1
