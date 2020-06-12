#!/bin/bash
#
# Display notification for low battery level
#
# Written by Wayne Campbell
##

main()
{
	while true
	do
	if [ "$(cat /sys/class/power_supply/BAT0/status)" != "Charging" ]; then
		bat=$(cat /sys/class/power_supply/BAT0/capacity)
		if [[ $bat -le 50 && $bat -gt 20 ]]; then
			notify-send "Battery Warning" "Warning: Battery level is ${bat}%"

		sleep 10m
		elif [[ $bat -le 20 && $bat -gt 5 ]]; then
			notify-send -u critical "Battery Warning" "Low: Battery level is ${bat}%"
		sleep 5m
		elif [[ $bat -le 5 ]]; then
			notify-send -u critical "Battery Warning" "Critial: Battery level is ${bat}%"
		sleep 1m
		fi
	fi
	sleep 10m
	done
}

main
