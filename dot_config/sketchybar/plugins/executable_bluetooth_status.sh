#!/bin/sh

STATUS=$(system_profiler SPBluetoothDataType | grep "Bluetooth Power" | awk '{print $3}')

if [ "$STATUS" = "On" ]; then
  COLOR="0xff1E90FF" # Bright blue if Bluetooth is enabled
else
  COLOR="0xff555555" # Gray if disabled
fi

# Apply color update WITHOUT overriding alias behavior
sketchybar --set "Control Center,Bluetooth" icon.color=$COLOR

