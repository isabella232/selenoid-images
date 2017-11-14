#!/bin/sh
VIDEO_SIZE=${VIDEO_SIZE:-"1920x1080"}
DISPLAY=${DISPLAY:-"99"}
FILE_NAME=${FILE_NAME:-"video.mp4"}
for i in {0..50}
do
	nc -z browser 60${PORT}
	if [ $? -ne 0 ]
	then
		echo 'wait...'
		sleep 0.1
	else	
		break
	fi
done
exec ffmpeg -y -f x11grab -video_size $VIDEO_SIZE -r 12 -i browser:$DISPLAY -codec:v libx264 "/data/$FILE_NAME"
