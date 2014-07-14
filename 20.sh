#!/bin/sh
# http://lifehacker.com/5591835/reduce-computer+caused-eye-strain-with-the-20+20+20-rule
# gnome-screensaver package is required

# Run this as normal user and not root!
# gnome-session-properties can be used to trigger this script after login.

while :
do
        sleep 20m
        # Note: The string we are doing a grep on might have changed between releases!
        if (gnome-screensaver-command -q | grep -q "inactive"); then
                notify-send --hint=int:transient:1 "Hey!" "Look away for 20 seconds"
        fi
        sleep 20s
done
