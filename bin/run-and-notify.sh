#!/bin/sh

SHOULD_LOOP=$1
shift 1

COMMAND="${@}"

eval $COMMAND

MESSAGE='Task is done: ```'"$COMMAND"'```'

if [ $SHOULD_LOOP = '1' ]; then
    while true; do
        slack-notify.sh "$MESSAGE"
        sleep 300
    done
else
    slack-notify.sh "$MESSAGE"
fi
