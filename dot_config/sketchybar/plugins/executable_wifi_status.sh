#!/bin/sh

# Detect active network interface for WiFi
INTERFACE=$(networksetup -listallhardwareports | awk '/Wi-Fi|AirPort/{getline; print $2}')
STATUS=$(networksetup -getairportpower "$INTERFACE" | awk '{print $NF}')

if [ "$STATUS" = "On" ]; then
  COLOR="0xff22a1f0" # Light blue if WiFi is enabled
else
  COLOR="0xff555555" # Gray if disabled
fi

# Apply color update WITHOUT overriding alias behavior
sketchybar --set "Control Center,WiFi" icon.color=$COLOR

