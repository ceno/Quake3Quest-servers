#!/bin/bash

QUAKE3_DIR=/opt/ioquake3
MAP_LIST="$1"
ALL_MAPS=$(ls ${QUAKE3_DIR}/baseq3/*.pk3  | grep -v pak  | xargs -I{} unzip -l {} | grep -o -E '\w*\.bsp' | grep -o -E '^\w*')
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

is_used () {
  map="$1"
  hide_output=$(grep -i "$map" $MAP_LIST < /dev/null)
  case $? in
      1) echo -e "${RED}[UNUSED]${NC}" ;;
      0) echo -e "${GREEN}[ USED ]${NC}" ;;
      *) echo -e "${RED}[UNUSED]${NC}" ;;
  esac
}

while read -r map ; do
	echo $(is_used "$map") "$map"
done <<< "$ALL_MAPS"

