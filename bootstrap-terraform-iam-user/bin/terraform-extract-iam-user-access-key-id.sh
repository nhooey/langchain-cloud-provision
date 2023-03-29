#!/bin/sh

terraform state pull | jq -r '.resources[] | select(.type == "aws_iam_access_key") | .instances[0].attributes.id'
