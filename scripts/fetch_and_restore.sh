#!/usr/bin/env bash
set -e
set -u
set -o pipefail

#: ${HEROKU_API_KEY?You must provide an HEROKU_API_KEY environment variable.}
#: ${AWS_ACCESS_KEY_ID?You must provide an AWS_ACCESS_KEY_ID as an environment variable.}
#: ${AWS_SECRET_ACCESS_KEY?You must provide an AWS_SECRET_ACCESS_KEY as an environment variable.}
#: ${AWS_REGION?You must provide a AWS_REGION as an environment variable.}
#
##: ${TARGET_DB_NAME?You must provide a TARGET_DB_NAME as an environment variable.}
##: ${TARGET_DB_HOST?You must provide a TARGET_DB_HOST as an environment variable.}
##: ${TARGET_DB_USER?You must provide a TARGET_DB_USER as an environment variable.}
##: ${TARGET_DB_PASSWORD?You must provide a TARGET_DB_PASSWORD as an environment variable.}
#
#env_vars=(
#    HEROKU_API_KEY=${HEROKU_API_KEY}
#    AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
#    AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
#    AWS_REGION=${AWS_REGION}
#)
#CMD="${env_vars[@]} docker run heroku-aws-connector "
#
#echo "${CMD}"
#eval "${CMD}"

