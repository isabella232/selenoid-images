#!/bin/sh
VIDEO_SIZE=${VIDEO_SIZE:-"1920x1080"}
BROWSER_CONTAINER_NAME=${BROWSER_CONTAINER_NAME:-"browser"}
DISPLAY=${DISPLAY:-"99"}
FILE_NAME=${FILE_NAME:-"video.mp4"}
FRAME_RATE=${FRAME_RATE:-"12"}
if [ -n "$LOCK_FILE" ]; then
    flock -x "$LOCK_FILE" read &
fi
retcode=1
echo 'Waiting for display to open...'
until [ $retcode -eq 0 ]; do
	xset -display ${BROWSER_CONTAINER_NAME}:${DISPLAY} b off > /dev/null 2>&1
	retcode=$?
	if [ $retcode -ne 0 ]; then
		echo 'Sleeping before next attempt...'
		sleep 0.1
	fi
done
exec ffmpeg -y -f x11grab -video_size $VIDEO_SIZE -r ${FRAME_RATE} -i $BROWSER_CONTAINER_NAME:$DISPLAY -codec:v libx264 "/data/$FILE_NAME"
