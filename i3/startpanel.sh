#!/bin/bash

killall -q polybar

sleep 1

MONITOR=HDMI-A-1 polybar top-left &
MONITOR=HDMI-A-1 polybar bottom-left &
#MONITOR=VGA-1-1 polybar top-right &
#MONITOR=VGA-1-1 polybar bottom-right &
