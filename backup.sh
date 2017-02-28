#! /bin/bash
set -e
set -o pipefail
DATE=$(date +%Y-%m-%d)
FILE=backup-$DATE.json.gz
firebase database:get / -P firebase-adtrak-bms --token $FIREBASE_TOKEN | gzip > $FILE
b2 authorize_account $B2_ID $B2_KEY
b2 upload_file adtrak-bms-backups $FILE $FILE

