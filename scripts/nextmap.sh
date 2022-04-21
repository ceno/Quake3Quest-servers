#!/bin/bash
RCON_PASSWORD="CHANGEME"
icecon -c "status" 127.0.0.1:27960 "$RCON_PASSWORD" | grep -o -E "map:.*"
NEXT_MAP=$(icecon -c nextmap 127.0.0.1:27960 "$RCON_PASSWORD" | grep nextmap | cut -d'"' -f4)
icecon -c "${NEXT_MAP::${#NEXT_MAP}-2}" 127.0.0.1:27960 "$RCON_PASSWORD"
icecon -c "status" 127.0.0.1:27960 "$RCON_PASSWORD" | grep -o -E "map:.*"
