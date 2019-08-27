#!/bin/bash -x
SERVICE="vault"
if pgrep -x "$SERVICE" >/dev/null
then
    pkill $SERVICE
else
    echo "$SERVICE stopped"  
fi

