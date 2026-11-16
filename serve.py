"""Serve the slides at http://localhost:8611 and open them in the browser.

Started by start-slides.command (Mac) or start-slides.bat (Windows).
Stop it by closing the window or pressing Ctrl+C.
Scores and edits are kept per address, so always use the same port.
"""
import functools
import http.server
import sys
import webbrowser
from pathlib import Path

PORT = 8611
URL = f"http://localhost:{PORT}/6B0slides.html"


class NoCache(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Cache-Control", "no-store")  # always serve the newest files
        super().end_headers()

    def log_message(self, *args):  # keep the window quiet
        pass


handler = functools.partial(NoCache, directory=str(Path(__file__).resolve().parent / "slides"))
try:
    server = http.server.ThreadingHTTPServer(("", PORT), handler)
except OSError:
    print(f"Port {PORT} is already in use, so the slides are probably running already.")
    print(f"Opening {URL}")
    webbrowser.open(URL)
    sys.exit(0)

print(f"Slides are running at {URL}")
print("Close this window (or press Ctrl+C) to stop.")
webbrowser.open(URL)
try:
    server.serve_forever()
except KeyboardInterrupt:
    pass
