#!/bin/bash
set -e
set -u
set -o pipefail

NAME="heroku-aws-connector"
VERSION=$(cat version.txt)

docker build . -t $NAME:$VERSION