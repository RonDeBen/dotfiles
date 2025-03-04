#!/bin/bash

# Set the directory to store the NASA images
NASA_IMAGE_DIR="$HOME/Pictures/NASA_Space_Images"

# Create the directory if it doesn't exist
mkdir -p "$NASA_IMAGE_DIR"

# Fetch the latest image from NASA's website
IMAGE_URL=$(curl -s "https://apod.nasa.gov/apod/astropix.html" | grep -oP 'href="\K[^"]+\.jpg' | head -n 1)

# Ensure the URL is valid
if [[ -z "$IMAGE_URL" ]]; then
    echo "❌ Failed to fetch NASA image URL."
else
    IMAGE_NAME=$(basename "$IMAGE_URL")
    IMAGE_PATH="$NASA_IMAGE_DIR/$IMAGE_NAME"

    # Try downloading the image
    curl -s -o "$IMAGE_PATH" "https://apod.nasa.gov/apod/$IMAGE_URL"

    # Check if the image download succeeded
    if [[ $? -ne 0 || ! -s "$IMAGE_PATH" ]]; then
        echo "❌ Failed to download NASA image. Selecting a random existing image."
        IMAGE_PATH=$(find "$NASA_IMAGE_DIR" -type f -name "*.jpg" | shuf -n 1)
    fi
fi

# If no valid image is found, exit safely
if [[ -z "$IMAGE_PATH" || ! -s "$IMAGE_PATH" ]]; then
    echo "❌ No valid NASA images available. Exiting."
    exit 1
fi

# Set the fetched image as your background (macOS method)
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "'"$IMAGE_PATH"'"'

echo "✅ NASA wallpaper set to: $IMAGE_PATH"
