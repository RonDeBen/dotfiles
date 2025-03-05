#!/bin/sh

# Handle volume change event
if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
fi

# Handle scroll event
if [ "$SENDER" = "mouse.scrolled" ]; then
  if [ "$SCROLL_DIR" = "up" ]; then
    osascript -e "set volume output volume (output volume of (get volume settings) + 5)"
  elif [ "$SCROLL_DIR" = "down" ]; then
    osascript -e "set volume output volume (output volume of (get volume settings) - 5)"
  fi
  VOLUME=$(osascript -e "output volume of (get volume settings)")
fi

# Determine icon based on volume level
case "$VOLUME" in
  [6-9][0-9]|100) ICON="󰕾" ;;  # High volume
  [3-5][0-9]) ICON="󰖀" ;;     # Medium volume
  [1-9]|[1-2][0-9]) ICON="󰕿" ;;  # Low volume
  0) ICON="󰖁" ;;               # Muted
esac

# Update Sketchybar item
sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"

