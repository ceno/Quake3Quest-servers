# Auto mapper

TODO:
- Make state file optional
- Solve how to set server config, like address and especially rcon password
- Make sure that every map is valid at startup script
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
