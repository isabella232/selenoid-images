#!/bin/bash
SCREEN_RESOLUTION=${SCREEN_RESOLUTION:-"1920x1080x24"}
/usr/bin/xvfb-run -a -s "-screen 0 $SCREEN_RESOLUTION -noreset" /usr/bin/selenoid -conf /etc/selenoid/browsers.json -disable-docker -timeout 1h -retry-count 3 -enable-file-upload -capture-driver-logs
