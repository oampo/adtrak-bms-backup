#! /bin/bash
set -e
set -o pipefail
DATE=$(date +%Y-%m-%d)
FILE=backup-v2-$DATE.json.gz
npm run firebase -- database:get / -P adtrak-bms2 --token $FIREBASE_TOKEN | gzip > $FILE
b2 authorize_account $B2_ID $B2_KEY
b2 upload_file adtrak-bms-backups $FILE $FILE

