#!/bin/bash

# Prints currently deployed stacks. Format is $name:$region $ip

STACK_LIST=$(npx aws-cdk list --long --json)
STACKS=$(echo "$STACK_LIST" | jq -r '.[] | (.id + ":" + .environment.region)')

while IFS= read -r line; do
	STACK=$(echo "$line" | cut -d':' -f1)
	REGION=$(echo "$line" | cut -d':' -f2)
	EIP=$(aws cloudformation describe-stacks --stack-name ${STACK} --region ${REGION} --query "Stacks[0].Outputs[?OutputKey=='ElasticIp'].OutputValue" --output text)
	echo $STACK:$REGION $EIP
done <<< "$STACKS"
