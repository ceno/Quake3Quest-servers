#!/bin/bash

LOGFILE="$1"

onlinePlayers=("Empty")
previousPlayer="Empty"

webhookForLogfile() {
  grep "$1:webhook" /etc/concierge.conf | cut -d"=" -f2
}

messageForLogfile() {
  grep "$1:message" /etc/concierge.conf | cut -d"=" -f2
}

filterOutBots() {
  grep --line-buffered -v -E "Orbb|Phobos|Visor|Slash|Tig|Keel|Gorre|TankJr|Razor|Bones|Orbb|Xaero|Sorlag|Stripe|Major|Lucy|Sarge|Hossman|Grunt|Hunter|Klesk|Bitterman|Cadavre|Ranger|Angel|Biker|Daemia|Crash|Angel|Mynx|\^1A\^2n\^3a\^4r\^5k\^6i|Doom|Wrack|Uriel|Patriot|Mandog|<world>"
}

player_name_from_enter() {
  #line='[2022-03-28 19:02:42] broadcast: print "[VR] Ceno^7 entered the game\n"'
  sliceA=${1:40:200}
  echo ${sliceA::-19}
}

player_name_from_disconnected() {
  #line='[2022-03-28 19:18:35] broadcast: print "FranK Hunter^7 disconnected\n"'
  sliceA=${1:40:200}
  echo ${sliceA::-15}
}

add_player() {
  get_index "$1"
  index=$?
  if [[ "$index" != "255" ]]; then
    echo $1 is already in the array
    return 0 
  fi
  onlinePlayers+=("$1")
  if [[ "$1" = "$previousPlayer" ]]; then
    echo $1 was the previous player - skipping
    return 0 
  fi
  discord --webhook-url "$WEBHOOK_URL" --username "Quake3Quest" --text "_${1//^[123456789]/} ${MESSAGE}_"
  previousPlayer="$1"
}

remove_player() {
  get_index "$1"
  index=$?
  if [[ "$index" = "255" ]]; then
    echo $1 is already NOT in the array
    return 0 
  fi

  unset "onlinePlayers[$index]"

  for i in "${!onlinePlayers[@]}"; do
      new_array+=( "${onlinePlayers[$i]}" )
  done
  onlinePlayers=("${new_array[@]}")
  unset new_array
}

print_players () {
  for i in "${!onlinePlayers[@]}"; do
    echo "${onlinePlayers[$i]}"
  done
}

get_index () {
  echo "Searching for $1"
  for i in "${!onlinePlayers[@]}"; do
   if [[ "${onlinePlayers[$i]}" = "$1" ]]; then
       return $i
   fi
  done
  return 255
}

main () {
  while read line
  do
    #echo "$line"
    if [[ "$line" == *"entered the game"* ]]; then
      echo JOINED
      player=$(player_name_from_enter "$line")
      add_player "$player"
    fi
    if [[ "$line" == *"disconnected"* ]]; then
      echo LEFT
      player=$(player_name_from_disconnected "$line")
      remove_player "$player"
    fi
  done < "${1:-/dev/stdin}"

}

# Load config
WEBHOOK_URL=$(webhookForLogfile "$LOGFILE")
MESSAGE=$(messageForLogfile "$LOGFILE")

echo $LOGFILE
echo $WEBHOOK_URL
echo $MESSAGE
if [[ -z "$LOGFILE" || -z "$WEBHOOK_URL" || -z "$MESSAGE" ]]; then
  echo 'one or more variables are undefined'
  exit 1
fi

# Start main loop
tail -n1 -f "$LOGFILE" | filterOutBots | main
