#!/bin/bash
# Generate <case>/assets/img/*.png from <case>/images.json. The first entry ("ref") is the character;
# every later image is drawn with ref.png as a reference so the student looks the same.
# Existing files are kept: delete one to redraw it.
#   tools/images.sh case1
set -e
cd "$(dirname "$0")/.."
CASE=$1; OUT="$CASE/assets/img"; mkdir -p "$OUT"
jq -r '.[] | "\(.name)\t\(.prompt)"' "$CASE/images.json" | while IFS=$'\t' read -r name prompt; do
  [ -f "$OUT/$name.png" ] && { echo "keep $name"; continue; }
  if [ "$name" = ref ]; then python3 tools/oa.py img "$prompt" "$OUT/ref.png"
  else python3 tools/oa.py img "$prompt" "$OUT/$name.png" "$OUT/ref.png"; fi
done
