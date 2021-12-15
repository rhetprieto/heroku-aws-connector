#!/bin/bash
set -e
set -u
set -o pipefail

NAME="heroku-aws-connector"
VERSION=$(cat version.txt)
CONNECTOR_IMAGE=$NAME:$VERSION
docker build . -t $CONNECTOR_IMAGE