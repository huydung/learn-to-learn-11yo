#!/bin/bash
# Cut slides/videos/caseN.mp4 at the vote card into caseN-1.mp4 (part 1) and caseN-2.mp4 (part 2),
# then remove the full file. Two files, because a plain local server cannot seek inside one.
#   tools/split.sh case1 35.2
set -e
cd "$(dirname "$0")/../../slides/videos"
CASE=$1; AT=$2
ENC=(-c:v libx264 -crf 18 -preset medium -pix_fmt yuv420p -c:a aac -b:a 192k -movflags +faststart)
ffmpeg -v error -y -i "$CASE.mp4" -t "$AT" "${ENC[@]}" "$CASE-1.mp4"
ffmpeg -v error -y -ss "$AT" -i "$CASE.mp4" "${ENC[@]}" "$CASE-2.mp4"
rm "$CASE.mp4"
echo "Wrote slides/videos/$CASE-1.mp4 and $CASE-2.mp4 (cut at ${AT}s)"
