# Auto mapper

A Linux service that provides map rotation adjusted for number of players for a
vanilla quake3 server. Requires the netcat package to be installed on the
system, as the service requires it to establish an RCON connection to the
server.  The package is installed by default on most Linux distros, including
raspbian.

The map list format is based on
[CPMA's](https://playmorepromode.com/guides/cpma-map-lists), even though the
algorithm is quite different. A minimal example wil look like this (see
`ffamaps.txt` for full file)
```
//MAP           MIN MAX
cpm1a             0 4
cpm15             4 7
akutadm3          7 12  // comment: https://ws.q3df.org/map/akutatdm3
```
Only these 3 options are supported (i.e. `0 4`, `4 7` and `7 12`). Fraglimit is
set per number of players. Timelimit is assumed to be constant, and relied upon
for resetting the server back to an appropriate map when all players leave.


#### Installation

Edit `auto-mapper@.service` with the RCON password to the server. Then

```
sudo make install
```

#### Reference commands to control service

```
sudo systemctl start auto-mapper@0
sudo systemctl stop auto-mapper@0
sudo systemctl restart auto-mapper@0
journalctl -f -u auto-mapper@0
```

#### TODO
- KNOWN ISSUE: doesn't work if a map name has a hyphen (e.g. pro-bgmp6). The regex needs adjusting
- Solve how to set server config, like address and especially rcon password, with an eye to support multiple quake3 instances per server. Conf file in /etc? How to parse it?
- Make sure that every map is valid at startup and fail if not? If a map is on the list but missing, the `map` rcon command will fail, and players will replay the map they just played.
