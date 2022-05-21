#!/bin/bash
TODAY=$(date +"%Y-%m-%d")
LOG_FILES="$@"
grep "$TODAY" $LOG_FILES | grep -o -E "Kill.* killed" | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr > /mnt/"$TODAY"-kills.txt
grep "$TODAY" $LOG_FILES | grep -oP "broadcast: print \\K.* hit the fraglimit" | cut -c 2- | rev | cut -c21- | rev | sort | uniq -c | sort -nr  > /mnt/"$TODAY"-wins.txt
grep "$TODAY" $LOG_FILES | grep MOD_RAILGUN | grep -o -E "Kill.* killed" | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - SNIPER: Railgun kills"}'  > /mnt/"$TODAY"-awards.txt
grep "$TODAY" $LOG_FILES | grep MOD_GAUNTLET | grep -o -E "Kill.* killed" | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - LEATHERFACE: Gauntlet kills"}'  >> /mnt/"$TODAY"-awards.txt
grep "$TODAY" $LOG_FILES | grep MOD_MACHINEGUN | grep -o -E "Kill.* killed" | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - SCARFACE: Machine gun kills"}'  >> /mnt/"$TODAY"-awards.txt
grep "$TODAY" $LOG_FILES | grep MOD_GRENADE | grep -o -E "Kill.* killed" | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - GRENADIER: Grenade launcher kills"}'  >> /mnt/"$TODAY"-awards.txt
grep "$TODAY" $LOG_FILES | grep MOD_LIGHTNING | grep -o -E "Kill.* killed" | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - STORM: Lightning kills"}'  >> /mnt/"$TODAY"-awards.txt
grep "$TODAY" $LOG_FILES | grep MOD_PLASMA | grep -o -E "Kill.* killed" | grep -v Orbb | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - PLASMOID: Plasma kills"}'  >> /mnt/"$TODAY"-awards.txt
grep "$TODAY" $LOG_FILES | grep MOD_ROCKET | grep -o -E "Kill.* killed" | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - LIFT OFF: Rocket kills"}'  >> /mnt/"$TODAY"-awards.txt
grep "$TODAY" $LOG_FILES | grep MOD_SHOTGUN | grep -o -E "Kill.* killed" | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - WILD WEST: Shotgun kills"}'  >> /mnt/"$TODAY"-awards.txt
grep "$TODAY" $LOG_FILES | grep MOD_BFG | grep -o -E "Kill.* killed" | cut -d":" -f3 | sed "s/ killed//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - BIG FUCKING AWARD: BFG kills"}'  >> /mnt/"$TODAY"-awards.txt
#^1R^1e^1t^1r^1o^71^1N
#grep "$TODAY" /mnt/server0.log | grep -o -E "Kill.* killed \^1R\^1e\^1t\^1r\^1o\^71\^1N" | cut -d":" -f3 | sed "s/ killed.*//g" | sort | uniq -c | sort -nr | head -n1 | awk '{print $0 " - SWEET VENGEANCE: Retro1N kills"}'  >> /mnt/"$TODAY"-awards.txt
#grep "$TODAY" /mnt/server0.log | grep -o -E "killed.* by" | cut -c 7- | rev | cut -c3- | rev | sort | uniq -c | sort -nr | head -n1  | awk '{print $0 " - TARGET PRACTICE: Killed in action"}' >> /mnt/"$TODAY"-awards.txt
