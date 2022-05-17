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
      1) echo -e "${RED}MISS${NC}" && return 1 ;;
      0) echo -e "${GREEN}OKAY${NC}" && return 0 ;;
      *) echo -e "${RED}MISS${NC}" && return 1 ;;
  esac
}

download_map () {
  map="$1"
  echo downloading $map
  #stdout=$(wget https://ws.q3df.org/maps/downloads/${map}.pk3)
  case $map in
      ktdsm3) wget https://ws.q3df.org/maps/downloads/${map}v2.pk3  ;;
      aepyra|qfraggel3ffa|s20dm4) wget https://ws.q3df.org/maps/downloads/map-${map}.pk3  ;;
      cpm*) wget https://ws.q3df.org/maps/downloads/map_${map}.pk3  ;;
      *) wget https://ws.q3df.org/maps/downloads/${map}.pk3  ;;
  esac
  sleep 5
}

echo "$MAPLIST_MINUS_COMMENTS" | grep -o -E "^[^ ]*" | while read map ; do
  result=$(is_installed "$map")
  case $? in
      1) download_map "$map" ;;
  esac
  echo $result $map
done

