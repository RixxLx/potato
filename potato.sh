#!/bin/bash

WORK=50
PAUSE=10
INTERACTIVE=false
MUTE=false

show_help() {
	cat <<-END
		usage: potato [-s] [-m] [-w m] [-b m] [-h]
		    -s: simple output. Intended for use in scripts
		        When enabled, potato outputs one line for each minute, and doesn't print the bell character
		        (ascii 007)

		    -m: mute -- don't play sounds when work/break is over
		    -w m: let work periods last m minutes (default is 25)
		    -b m: let break periods last m minutes (default is 5)
		    -h: print this message
	END
}

play_notification() {
	aplay -q /usr/lib/potato/notification.wav&
}

while getopts :sw:b:m opt; do
	case "$opt" in
	s)
		INTERACTIVE=false
	;;
	m)
		MUTE=true
	;;
	w)
		WORK=$OPTARG
	;;
	b)
		PAUSE=$OPTARG
	;;
	h|\?)
		show_help
		exit 1
	;;
	esac
done

time_left="%im left of %s "

if $INTERACTIVE; then
	time_left="\r$time_left"
else
	time_left="$time_left\n"
fi

while true
do
	for ((i=$WORK; i>0; i--))
	do
		printf "$time_left" $i "work"
		if [ "$i" = "$WORK" ]; then
			notify-send "Get shit done"
                fi
		sleep 1m
	done

	! $MUTE && play_notification
	if $INTERACTIVE; then
		read -d '' -t 0.001
		echo -e "\a"
		echo "Session is over"
		read
	fi

	for ((i=$PAUSE; i>0; i--))
	do
		printf "$time_left" $i "pause"
		if [ "$i" = "$PAUSE" ]; then
                        notify-send "Take a break"
                fi
		sleep 1m
	done

	! $MUTE && play_notification
	if $INTERACTIVE; then
		read -d '' -t 0.001
		echo -e "\a"
		echo "Break is over"
		read
	fi
done
