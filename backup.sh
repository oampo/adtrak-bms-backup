#! /bin/bash
set -e
set -o pipefail
DATE=$(date +%Y-%m-%d)
FILE=backup-$DATE.json.gz
firebase database:get / -P firebase-adtrak-bms --token $FIREBASE_TOKEN | gzip > $FILE
STATUS=$(curl -s -o /dev/stderr -w "%{http_code}" --user "API:$MAILGUN_KEY" \
    https://api.mailgun.net/v3/sandbox66670e8080dd4553897f19a3513bb637.mailgun.org/messages \
    -F from="Adtrak BMS <adtrak-bms@sandbox66670e8080dd4553897f19a3513bb637.mailgun.org>" \
    -F to=$RECIPIENT \
    -F text="Backup for $DATE" \
    -F subject="Backup $DATE" \
    -F attachment=@$FILE)

if test $STATUS -ne 200; then
    exit 1;
fi

