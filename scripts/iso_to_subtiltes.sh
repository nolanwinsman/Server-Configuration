#!/bin/bash

# Define the path to the BDMV/STREAM directory
ISO_PATH="/mnt/iso/BDMV/STREAM"

# Check if the directory exists
if [ ! -d "$ISO_PATH" ]; then
  echo "Directory $ISO_PATH not found. Please check the mount."
  exit 1
fi

# Loop through each .m2ts file in the directory
for file in "$ISO_PATH"/*.m2ts; do
  echo "Checking $file for subtitles..."

  # Get ffmpeg output for stream details
  ffmpeg_output=$(ffmpeg -i "$file" 2>&1)

  # Look for subtitle streams in the output
  subtitle_count=$(echo "$ffmpeg_output" | grep -i "Subtitle" | wc -l)

  if [ "$subtitle_count" -gt 0 ]; then
    echo "Subtitles found in: $file"
    
    # Extract subtitle streams (if any)
    stream_indexes=$(echo "$ffmpeg_output" | grep -i "Subtitle" | sed -n 's/.*Stream #0:\([0-9]\+\): Subtitle.*/\1/p')
    
    # For each subtitle stream, extract it as an .srt file
    count=1
    for index in $stream_indexes; do
      output_filename="${file%.m2ts}_subtitle${count}.srt"
      echo "Extracting subtitle stream $index from $file..."
      ffmpeg -i "$file" -map 0:s:$index -c:s srt "$output_filename"
      echo "Subtitle extracted to: $output_filename"
      count=$((count + 1))
    done
  else
    echo "No subtitles found in: $file"
  fi

  echo "----------------------------"
done

