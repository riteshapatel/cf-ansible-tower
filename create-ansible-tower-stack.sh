#!/bin/sh

################################################################################
# Script for testing ansible tower stack. It creates all required resources for
# Ansible Tower.
# Usage: ./create-ansible-tower-stack.sh --capabilities CAPABILITY_NAMED_IAM
################################################################################
# AWS profile from .credentials
PROFILE='raptest'
# stack region
REGION='us-east-1'
# stack name
STACK_NAME='rap-dryrun-ansible-tower'
# replace location with the template on your machine :D
TEMPLATE='file://~/code/cf-ansible-tower/ansible-tower.template'

# validate template
echo 'validate template...'
aws cloudformation validate-template --profile $PROFILE --region $REGION --template-body $TEMPLATE
sleep 10s

# delete existing stack (if any)
echo 'deleting stack...'
aws cloudformation --profile $PROFILE --region $REGION delete-stack --stack-name $STACK_NAME
sleep 10s

# create a new stack
echo 'creating stack...'
aws cloudformation --profile $PROFILE --region $REGION create-stack --stack-name $STACK_NAME --template-body $TEMPLATE --capabilities CAPABILITY_NAMED_IAM