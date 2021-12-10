#!/bin/bash
set -e
set -u
set -o pipefail

# This script pushes the latest build to ECR.

NAME="heroku-aws-connector"
CLUSTER_NAME="heroku-aws-connector"
REGION="us-east-1"
VERSION=$(cat version.txt)

echo Logging into ECR ...
# Login to docker
$(aws ecr get-login --region $REGION | sed -e 's/-e none//g')

## Fetch repository name
REPOSITORY_URI=`aws ecr describe-repositories --repository-names ${NAME} --region ${REGION} | jq .repositories[].repositoryUri | tr -d '"'`
echo Found ECR repository: $REPOSITORY_URI

CONNECTOR_IMAGE=$REPOSITORY_URI:$VERSION
echo Tagging and pushing latest for ECR with version: $VERSION ...

echo $CONNECTOR_IMAGE
docker tag $NAME $CONNECTOR_IMAGE
docker push $CONNECTOR_IMAGE
