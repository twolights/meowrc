#!/bin/sh

. ~/.secrets/slack

curl \
    --data-urlencode "text=$2" \
    --data-urlencode "token=$SLACK_TOKEN" \
    --data-urlencode "channel=$1" \
    https://slack.com/api/chat.postMessage
