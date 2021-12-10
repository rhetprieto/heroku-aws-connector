#!/bin/sh
set -e
set -u
set -o pipefail
USAGE="This script runs the db migration tasl to ecs"

: ${HEROKU_API_KEY?You must provide an HEROKU_API_KEY environment variable.}
: ${HEROKU_APP_NAME?You must provide an HEROKU_APP_NAME environment variable.}

: ${TARGET_DB_HOST?You must provide a TARGET_DB_HOST as an environment variable.}
: ${TARGET_DB_USER?You must provide a TARGET_DB_USER as an environment variable.}
: ${TARGET_DB_NAME?You must provide a TARGET_DB_NAME as an environment variable.}
: ${NUMBER_OF_JOBS?You must provide a NUMBER_OF_JOBS as an environment variable.}

REPOSITORY_NAME=${REPOSITORY_NAME:-heroku-aws-connector}
CLUSTER_NAME=${CLUSTER_NAME:-heroku-aws-connector}
REGION=${AWS_REGION:-us-east-1}
NAME=${NAME:-heroku-aws-connector}
VERSION=${VERSION:-$(cat version.txt)}

REPOSITORY_URI=`aws ecr describe-repositories --repository-names ${REPOSITORY_NAME} --region ${REGION} | jq .repositories[].repositoryUri | tr -d '"'`
CONNECTOR_IMAGE=$REPOSITORY_URI:$NAME:$VERSION

ecs-cli configure --cluster $CLUSTER_NAME --region $REGION --default-launch-type EC2

env_vars=(
    HEROKU_API_KEY=${HEROKU_API_KEY}
    HEROKU_APP_NAME=${HEROKU_APP_NAME}
    TARGET_DB_HOST=${TARGET_DB_HOST}
    TARGET_DB_USER=${TARGET_DB_USER}
    TARGET_DB_NAME=${TARGET_DB_NAME}
    NUMBER_OF_JOBS=${NUMBER_OF_JOBS}
)
compose_options=(
    --region "${REGION}"
    --cluster "${CLUSTER_NAME}"
    --project-name "${NAME}"
    --file ./docker-compose.yml
)
CMD="${env_vars[@]} ecs-cli compose ${compose_options[@]} start  --ecs-params ecs-params.yml"

echo "${CMD}"
eval "${CMD}"