#!/bin/bash

QUAKE3_DIR=/opt/ioquake3
MAP_LIST="$1"
MAPLIST_MINUS_COMMENTS=$(sed -e "s/\s*\/\/.*//g" "$MAP_LIST")
ALL_MAPS=$(ls ${QUAKE3_DIR}/baseq3/*.pk3 | xargs -I{} unzip -l {})
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

is_installed () {
  map="$1"
  hide_output=$(grep -o -E -i "${map}.bsp|${map}.aas" <<< "$ALL_MAPS")
  case $? in
      1) echo -e "${RED}MISS${NC}" ;;
      0) echo -e "${GREEN}OKAY${NC}" ;;
      *) echo -e "${RED}MISS${NC}" ;;
  esac
}

echo "$MAPLIST_MINUS_COMMENTS" | grep -o -E "^[^ ]*" | while read map ; do
   echo $(is_installed "$map") $map
done
