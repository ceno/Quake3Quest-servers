#!/bin/bash

if [ -z "$1" ]; then
	STACK_LIST=$(npx aws-cdk list --long --json)
	STACKS=$(echo "$STACK_LIST" | jq -r '.[] | (.id + ":" + .environment.region)')
else
	STACKS="$1"
fi

echo TO REFRESH
echo "$STACKS"
echo "************************"

while IFS= read -r line; do
	STACK=$(echo "$line" | cut -d':' -f1)
	REGION=$(echo "$line" | cut -d':' -f2)

	echo $STACK
	ASG=$(aws cloudformation describe-stacks --stack-name ${STACK} --region ${REGION} --query "Stacks[0].Outputs[?OutputKey=='ASG'].OutputValue" --output text)
	
	aws autoscaling start-instance-refresh --auto-scaling-group-name ${ASG} --region ${REGION}
done <<< "$STACKS"
