#!/bin/bash

# Get the current working directory where the script is being run
OUTPUT_DIR="$(pwd)"

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
  subtitle_count=0
  ffmpeg -i "$file" 2>&1 | grep -i "Subtitle" | while read -r line; do
    # Extract subtitle stream index (e.g., Stream #0:2)
    stream_index=$(echo "$line" | sed -n 's/.*Stream #0:\([0-9]\+\): Subtitle.*/\1/p')

    # If a subtitle stream is found, extract it
    if [ -n "$stream_index" ]; then
      subtitle_count=$((subtitle_count + 1))
      # Get the base filename (without path) for output naming
      base_filename=$(basename "$file")
      output_filename="${OUTPUT_DIR}/${base_filename}_subtitle${subtitle_count}.srt"
      echo "Extracting subtitle track $subtitle_count from $file..."

      # Extract the subtitle track to an .srt file in the current directory
      ffmpeg -i "$file" -map 0:s:"$stream_index" "$output_filename"
      echo "Subtitle extracted to: $output_filename"
    fi
  done

  # If no subtitles were found
  if [ "$subtitle_count" -eq 0 ]; then
    echo "No subtitles found in: $file"
  fi

  echo "----------------------------"
done

