#!/bin/bash

PID=$(ps x | grep spotify | grep -v grep)

if [[ ! -z "$PID" ]]; then
  RESULTX="$(/usr/local/bin/spotify status 2>/dev/null; echo x)"
fi

RESULT="${RESULTX%x}"

echo "$(echo "$RESULT" | grep "Artist" | awk -F":" '{print $2}')@$(echo "$RESULT" | grep "Track:" | awk -F":" '{print $2}')@$(echo "$RESULT" | grep "Position:" | awk -F" " '{print $2}')@$(echo "$RESULT" | grep "Position:" | awk -F" " '{print $4}')@$(echo "$RESULT" | grep 'Spotify is currently' | awk -F" " '{print $4}')"
