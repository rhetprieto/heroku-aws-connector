#!/usr/bin/env bash
set -e
set -u
set -o pipefail

NAME=${NAME:-heroku-aws-connector}
VERSION=${VERSION:-$(cat version.txt)}

docker build . -t $NAME:$VERSION