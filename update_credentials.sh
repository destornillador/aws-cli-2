#!/bin/bash -e

# Log in to AWS
aws sso login --profile $AWS_PROFILE

# Update credentials file
aws-sso-cred-restore --profile $AWS_PROFILE

exit 0
