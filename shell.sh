#!/bin/bash

SITE="http://10.0.2.15/"

WEBHOOK="https://discordapp.com/api/webhooks/..."

LOGDIR="/var/log"
LOGFILE="$LOGDIR/monitorizacao.log"

mkdir -p "$LOGDIR"
sudo touch "$LOGFILE"

while :; do

STATUS=$( curl -s -o /dev/null -w "%{http_code}" http://10.0.2.15/ )

DATA=$(date "+%d/%m/%Y %H:%M:%S")

if [[ "$STATUS" -eq 200 ]]; then
    
    MENSAGEM="[$DATA] O site $SITE está online. (Status: $STATUS) ✅"
    curl -H "Content-Type: application/json"\
       -d "{\"content\": \"$MENSAGEM\"}" \
       $WEBHOOK
    
    else
    MENSAGEM="[$DATA] O site $SITE está fora do ar. (Status: $STATUS) ❌"
     curl -H "Content-Type: application/json"\
        -d "{\"content\": \"$MENSAGEM\"}" \
        $WEBHOOK

fi
    echo "$MENSAGEM" >> "$LOGFILE"
    
    sleep 60 
done