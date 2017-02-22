#! /bin/bash

DATE=`date +%Y-%m-%d`
FILE=backup-$DATE.json.gz
firebase database:get / -P firebase-adtrak-bms --token $FIREBASE_TOKEN | gzip > $FILE
curl -s --user "API:$MAILGUN_KEY" \
    https://api.mailgun.net/v3/sandbox66670e8080dd4553897f19a3513bb637.mailgun.org/messages \
    -F from="Adtrak BMS <adtrak-bms@sandbox66670e8080dd4553897f19a3513bb637.mailgun.org>" \
    -F to=$RECIPIENT \
    -F text="Backup for $DATE" \
    -F subject="Backup $DATE" \
    -F attachment=@$FILE

