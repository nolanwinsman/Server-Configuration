#!/bin/bash

# Define the path to the BDMV/STREAM directory
ISO_PATH="/mnt/iso/BDMV/STREAM"

# Check if the directory exists
if [ ! -d "$ISO_PATH" ]; then
  echo "Directory $ISO_PATH not found. Please check the mount."
  exit 1
fi

# Loop through each file in the directory
for file in "$ISO_PATH"/*; do
  # Skip directories
  if [ -d "$file" ]; then
    continue
  fi

  echo "Checking $file for subtitles..."

  # Use ffmpeg to check for subtitle streams in the file
  ffmpeg -i "$file" 2>&1 | grep -i "Subtitle"

  # Check if subtitles were found and print the result
  if [ $? -eq 0 ]; then
    echo "Subtitles found in: $file"
  else
    echo "No subtitles found in: $file"
  fi

  echo "----------------------------"
done

