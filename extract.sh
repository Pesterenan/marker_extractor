#!/bin/bash

echo -e "Marker Extractor v0.0.1 - Pesterenan\n"
if [[ $# -ne 1 || "$1" = "--help" ]]; then
  echo "Usage: $0 <video_file.mp4>"
  exit 1
fi

video_file=$1

if [[ ! -f "$video_file" ]]; then
  echo "Error: The file '$video_file' does not exist."
  exit 1
fi

# Extract metadata using ffprobe, getting chapter information:
chapters_info=$(ffprobe -v error -show_entries chapter -of default=noprint_wrappers=1:nokey=1 "$video_file")

# Process a group of seven lines into a formatted timecode
function process_chapters()
{
  IFS=$'\n'
  line_count=0
  chapter_start_time=''
  chapter_title=''
  for line in $chapters_info; do
    ((line_count++))
    case $line_count in
      4) chapter_start_time=$(echo "$line" | awk '{printf "%.0f", $1}');;
      7) chapter_title=$line
        if echo "$chapter_title" | grep -q "Start"; then
          chapter_title="Capítulos:"
        fi
        if [[ -n "$chapter_start_time" ]]; then
          formatted_start_time=$(printf "%02d:%02d:%02d" $((chapter_start_time/3600)) $(((chapter_start_time/60)%60)) $((chapter_start_time%60)))
          formatted_output+="$formatted_start_time - $chapter_title"$'\n'
        else
          echo "Error: Invalid chapter_start_time."
        fi
        line_count=0 ;;
    esac
  done
}


if [ -n "$chapters_info" ]; then
  echo -e "Extracting chapters information:\n"
  process_chapters
  echo -e "$formatted_output" 

  file_path=$(dirname "$video_file")
  file_name=$(echo "$video_file" | awk -F "/" '{gsub(/\.[^.]*$/, "", $NF); print $NF}')
  file_name+="_Chapters.txt"
  echo "Saving chapters information to text file: \"$file_name\""
  echo -e "$formatted_output" > "$file_path/$file_name"
else
  echo "No chapter information found."
fi

