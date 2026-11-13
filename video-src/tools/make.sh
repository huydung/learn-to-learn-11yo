#!/bin/bash
# Rebuild one video end to end and copy it into the slides.
#   tools/make.sh case1 [vieneu] ["Ngọc Linh"]  # free VieNeu voice (default)
#   tools/make.sh case1 openai   # OpenAI voice + images (needs API credits)
set -e
cd "$(dirname "$0")/.."
CASE=$1; ENGINE=${2:-vieneu}
tools/voice.sh "$CASE" "$ENGINE" "${3:-}"
[ "$ENGINE" = openai ] && tools/images.sh "$CASE"
python3 tools/build.py "$CASE"
cd "$CASE" && HYPERFRAMES_NO_TELEMETRY=1 npx hyperframes check >/dev/null
HYPERFRAMES_NO_TELEMETRY=1 npx hyperframes render --quality looks -o "../../slides/videos/$CASE.mp4" | tail -3
echo "Now set pauseAt for $CASE in slides/content.js (VIDEOS) to the value printed above."
