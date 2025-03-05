sketchybar --set $NAME \
  label="Loading..." \
  icon.color=0xff5edaff

# Fetch weather data
LOCATION="Hong Kong"
REGION="Central and Western"
COUNTRY="HK"

# Line below replaces spaces with +
LOCATION_ESCAPED="${LOCATION// /+}+${REGION// /+}"
WEATHER_JSON=$(curl -s "https://wttr.in/$LOCATION_ESCAPED?format=j1")

# Fallback if empty
if [ -z "$WEATHER_JSON" ]; then
  sketchybar --set $NAME label="$LOCATION"
  return
fi

# Extract temperature in Celsius
TEMPERATURE_C=$(echo "$WEATHER_JSON" | jq '.current_condition[0].temp_C' | tr -d '"')

# Convert Celsius to Fahrenheit
TEMPERATURE_F=$(echo "scale=1; ($TEMPERATURE_C * 9/5) + 32" | bc)

# Extract weather description
WEATHER_DESCRIPTION=$(echo "$WEATHER_JSON" | jq '.current_condition[0].weatherDesc[0].value' | tr -d '"' | sed 's/\(.\{16\}\).*/\1.../')

# Set Sketchybar label with Fahrenheit temperature
sketchybar --set $NAME \
  label="$TEMPERATURE_F$(echo '°')F • $WEATHER_DESCRIPTION"

