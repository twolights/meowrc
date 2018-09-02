#!/bin/sh

. ~/.secrets/slack

curl \
    --data-urlencode "text=$1" \
    --data-urlencode "token=$SLACK_TOKEN" \
    --data-urlencode 'channel=headsup' \
    https://slack.com/api/chat.postMessage
