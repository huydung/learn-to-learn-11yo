#!/bin/bash
# Mac: double-click to start the slides server and open the deck. Close the window to stop.
cd "$(dirname "$0")" || exit 1
python3 serve.py
