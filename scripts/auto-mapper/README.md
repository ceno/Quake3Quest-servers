# Auto mapper

A Linux service that provides automatic map rotation for a quake3 server using
RCON.

The map list format is based on
[CPMA's](https://playmorepromode.com/guides/cpma-map-lists), even though the
algorithm is quite different. A minimal example wil look like this (see
`ffamaps.txt` for full file)
```
cpm1a             0 4
cpm15             4 7
akutadm3          7 12
```
Only these 3 options are supported (i.e. `0 4`, `4 7` and `7 12`). Fraglimit is
set per number of players. Timelimit is assumed to be constant, and relied upon
for resetting the server back to an appropriate map when all players leave.


#### Installation

```
sudo make install
```

#### Reference dommands to control service

```
sudo systemctl start auto-mapper@0
sudo systemctl stop auto-mapper@0
sudo systemctl restart auto-mapper@0
journalctl -f -u auto-mapper@0
```

#### TODO
- Solve how to set server config, like address and especially rcon password, with an eye to support multiple quake3 instances per server. Conf file in /etc? How to parse it?
- Make sure that every map is valid at startup and fail if not? If a map is on the list but missing, the `map` rcon command will fail, and players will replay the map they just played.
- Replace icecon with direct calls to nc like so:

```
#22:14:50 map-picker $ printf "\xff\xff\xff\xffrcon PASSWORD vstr d1" | nc -u -w1 13.38.149.128 27960
#????print
#22:15:05 map-picker $ printf "\xff\xff\xff\xffrcon PASSWORD status" | nc -u -w1 13.38.149.128 27960
#????print
#map: q3tourney2
#cl score ping name            address                                 rate 
#-- ----- ---- --------------- --------------------------------------- -----
#
#22:15:09 map-picker $ printf "\xff\xff\xff\xffrcon PASSWORD vstr d2" | nc -u -w1 13.38.149.128 27960
#????print
#22:15:17 map-picker $ printf "\xff\xff\xff\xffrcon PASSWORD status" | nc -u -w1 13.38.149.128 27960
#????print
```
