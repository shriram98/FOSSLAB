#!/bin/bash


wget -O source.html www.google.com > /dev/null 2>&1

while :
do
	wget -O compare.html www.google.com > /dev/null 2>&1
	cmp --silent compare.html source.html
	if [ $? -eq 1 ]; then
		notify-send "file changed"
		mv compare.html source.html
	fi
	sleep 5
done
