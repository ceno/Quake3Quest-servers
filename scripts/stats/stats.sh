#!/bin/bash

daily_matches() {
	grep $@ | \
	grep "score: " | \
	grep -v -E "Orbb|Phobos|Visor|Slash|Tig|Keel|Gorre|TankJr|Razor|Bones|Orbb|Xaero|Sorlag|Stripe|Major|Lucy|Sarge|Hossman|Grunt|Hunter|Klesk|Bitterman|Cadavre|Ranger|Angel|Biker|Daemia|Crash|Angel|Mynx|\^1A\^2n\^3a\^4r\^5k\^6i|Doom|Wrack|Uriel|Patriot|Mandog" | \
	cut -d" " -f2 | uniq | wc -l
}

daily_uniques() {
	grep  $@ | \
	grep "entered the game" | \
	grep -v -E "Orbb|Phobos|Visor|Slash|Tig|Keel|Gorre|TankJr|Razor|Bones|Orbb|Xaero|Sorlag|Stripe|Major|Lucy|Sarge|Hossman|Grunt|Hunter|Klesk|Bitterman|Cadavre|Ranger|Angel|Biker|Daemia|Crash|Angel|Mynx|\^1A\^2n\^3a\^4r\^5k\^6i|Doom|Wrack|Uriel|Patriot|Mandog" | \
	grep -o -E '\".*\^7' | sort  | uniq | wc -l
}

# export functions so that they can be called from xargs, using that weird bash -c thing
export -f daily_matches
export -f daily_uniques

DAYS_SINCE_MAY_10_2022=$(( ( $(date +%s) - $(date --date="220510" +%s) )/(60*60*24) ))

DATES=$(seq 0 $DAYS_SINCE_MAY_10_2022 | xargs -I{} date --date="Tue May 10 12:00:00 UTC 2022+{} days" "+%Y-%m-%d")
DEMO_MATCHES=$(  echo "$DATES" | xargs -I{} bash -c "daily_matches {} /mnt/server1.log")
DEMO_UNIQUES=$(  echo "$DATES" | xargs -I{} bash -c "daily_uniques {} /mnt/server1.log")
MEETUP_MATCHES=$(echo "$DATES" | xargs -I{} bash -c "daily_matches {} /mnt/server0.log")
MEETUP_UNIQUES=$(echo "$DATES" | xargs -I{} bash -c "daily_uniques {} /mnt/server0.log")

paste <(printf "%s\n" "Date" "$DATES") \
      <(printf "%s\n" "Demo_matches" "$DEMO_MATCHES") \
      <(printf "%s\n" "Meetup_matches" "$MEETUP_MATCHES") \
      <(printf "%s\n" "Demo_uniques" "$DEMO_UNIQUES") \
      <(printf "%s\n" "Meetup_uniques" "$MEETUP_UNIQUES") | column -t -o ","
