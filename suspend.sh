#!/bin/sh

FILE=/tmp/sleeping
if [ -f "$FILE" ]; then
	brightnessctl -d "backlight_warm"  $(sed -n 0p $FILE)
	rm $FILE
        notify-send "Welcome back" "Waking up..." -t 1000
        echo 1-0024 | sudo tee /sys/bus/i2c/drivers/cyttsp5/unbind
	sleep 1
        echo 1-0024 | sudo tee /sys/bus/i2c/drivers/cyttsp5/bind
else
	touch $FILE
	brightnessctl -d "backlight" g > $FILE
	brightnessctl -d "backlight" s 0
	notify-send "Sleeping" "zzz" -t 2000
	sleep 
	sudo pm-suspend
fi

