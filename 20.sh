#!/bin/sh
# http://lifehacker.com/5591835/reduce-computer+caused-eye-strain-with-the-20+20+20-rule
# gnome-screensaver package is required

while :
do
        sleep 20m
        if (gnome-screensaver-command -q | grep -q "is inactive"); then
                notify-send -t 1000 "20-20-20" "Look away for 20 seconds"
        fi
        sleep 20s
done
