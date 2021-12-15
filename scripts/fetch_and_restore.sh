#!/usr/bin/env bash
set -e
set -u

echo "Downloading DB backup to local dump"
curl -o db.dump `heroku pg:backups public-url --app=${HEROKU_APP_NAME}`
echo "Restoring DB"
pg_restore --verbose --clean --no-acl --no-owner -h ${TARGET_DB_HOST} -U ${TARGET_DB_USER} -d ${TARGET_DB_NAME} --jobs=${NUMBER_OF_JOBS} db.dump
echo "Process finished"