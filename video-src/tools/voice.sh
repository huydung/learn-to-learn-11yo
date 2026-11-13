#!/bin/bash
# Make one narration file per line of <case>/script.json, then print each line's duration.
#   tools/voice.sh case1 linh            # free macOS draft voice
#   tools/voice.sh case1 vieneu ["Ngọc Linh"]  # free VieNeu-TTS on this Mac (default engine)
#   tools/voice.sh case1 openai [voice]  # gpt-4o-mini-tts (needs API credits)
set -e
cd "$(dirname "$0")/.."
CASE=$1; ENGINE=${2:-vieneu}; VOICE=${3:-}
OUT="$CASE/assets/voice"; mkdir -p "$OUT"
if [ "$ENGINE" = vieneu ]; then
  .venv/bin/python tools/vieneu_tts.py batch "$CASE/script.json" "$OUT" "${VOICE:-Ngọc Linh}" 2>/dev/null
  for f in "$OUT"/*.wav; do afconvert -f m4af -d aac "$f" "${f%.wav}.m4a" && rm "$f"; done
fi
jq -r '.[] | "\(.id)\t\(.say)"' "$CASE/script.json" | while IFS=$'\t' read -r id text; do
  if [ "$ENGINE" = vieneu ]; then :
  elif [ "$ENGINE" = openai ]; then
    VOICE=${VOICE:-coral}
    python3 tools/oa.py tts "$text" "$OUT/$id.mp3" "$VOICE" >/dev/null
    afconvert -f m4af -d aac "$OUT/$id.mp3" "$OUT/$id.m4a" && rm "$OUT/$id.mp3"
  else
    say -v Linh -r 165 -o "$OUT/$id.aiff" "$text"
    afconvert -f m4af -d aac "$OUT/$id.aiff" "$OUT/$id.m4a" && rm "$OUT/$id.aiff"
  fi
  printf '%s\t%s\n' "$id" "$(afinfo "$OUT/$id.m4a" | awk '/estimated duration/ {print $3}')"
done
