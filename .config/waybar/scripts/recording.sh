#!/bin/sh

if pgrep -x "wf-recorder" > /dev/null
then
    status="Running"
else
    status="Stopped"
fi

echo "{\"alt\": \"$status\"}"

