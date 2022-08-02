#!/bin/bash

SEARCHTERM=$1
curl -s https://q3quest-api.s3.eu-west-3.amazonaws.com/serverstatus | jq -r ".[] | select(.hostname | contains(\"$SEARCHTERM\")) | .hostname + \"\n\t\" + .ip"
