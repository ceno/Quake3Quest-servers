#!/bin/bash

S3_BUCKET_LIST=$(npx aws-cdk list --long --json | jq -r ".[].id | ascii_downcase")

echo "$S3_BUCKET_LIST" | xargs -t -I {} aws s3 sync --dryrun --size-only --exclude ".DS_Store" ../dist s3://{}

echo dont forget to manually sync the buckets NOT managed by cdk
