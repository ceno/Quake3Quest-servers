#!/bin/bash

while :
do
	echo $(date +"[%Y-%m-%d %H:%M:%S]") $(sh $1) | tee -a results.txt
	sleep 5
done
