#!/bin/bash
# Rebuild one video end to end and copy it into the slides as two parts (caseN-1.mp4, caseN-2.mp4).
#   tools/make.sh case1 [vieneu] ["Ngọc Linh"]  # free VieNeu voice (default)
#   tools/make.sh case1 openai   # OpenAI voice + images (needs API credits)
set -e
cd "$(dirname "$0")/.."
CASE=$1; ENGINE=${2:-vieneu}
tools/voice.sh "$CASE" "$ENGINE" "${3:-}"
[ "$ENGINE" = openai ] && tools/images.sh "$CASE"
AT=$(python3 tools/build.py "$CASE" | tee /dev/stderr | sed -n 's/^pauseAt: \([0-9.]*\).*/\1/p')
cd "$CASE" && HYPERFRAMES_NO_TELEMETRY=1 npx hyperframes check >/dev/null
HYPERFRAMES_NO_TELEMETRY=1 npx hyperframes render --quality looks -o "../../slides/videos/$CASE.mp4" | tail -3
cd .. && tools/split.sh "$CASE" "$AT"
