#!/bin/bash
echo set g_gametype 0
echo set fraglimit 20
echo
MAPS=$(cat "$1")
TOTAL_LINES=$(echo "$MAPS" | wc -l)
i=1
for map in $MAPS
do
	if [ $i -lt 10 ]; then
		echo -n set d$i'  "map' $map '; '
	else
		echo -n set d$i' "map' $map '; '
	fi

	if [ $i = $TOTAL_LINES ]; then
		echo -n set nextmap vstr d1'"'
	else
		echo -n set nextmap vstr d$(( i + 1 ))'"'
	fi

	echo -e '\t'// https://ws.q3df.org/map/$map
	i=$(( i + 1 ))
done
echo vstr d1
