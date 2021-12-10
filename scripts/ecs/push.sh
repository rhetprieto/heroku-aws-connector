#!/usr/bin/env bash
set -e
set -u
set -o pipefail

# This script pushes the latest build to ECR.

REPOSITORY_NAME=${REPOSITORY_NAME:heroku-aws-connector}
REGION=${REGION:-us-east-1}
NAME=${NAME:-heroku-aws-connector}
VERSION=${VERSION:-$(cat ../../version.txt)}

echo Logging into ECR ...
# Login to docker
$(aws ecr get-login --region $REGION | sed -e 's/-e none//g')

## Fetch repository name
REPOSITORY_URI=`aws ecr describe-repositories --repository-names ${REPOSITORY_NAME} --region ${REGION} | jq .repositories[].repositoryUri | tr -d '"'`
echo Found ECR repository: $REPOSITORY_URI

CONNECTOR_IMAGE=$REPOSITORY_URI:$NAME:$VERSION
echo Tagging and pushing latest for ECR with version: $VERSION ...

echo $CONNECTOR_IMAGE
docker tag $NAME $CONNECTOR_IMAGE
docker push $CONNECTOR_IMAGE
