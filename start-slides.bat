@echo off
rem Windows: double-click to start the slides server and open the deck. Close the window to stop.
cd /d "%~dp0"
where py >nul 2>nul
if %errorlevel%==0 (
  py serve.py
) else (
  python serve.py
)
if errorlevel 9009 (
  echo.
  echo Could not find Python. Install it from https://www.python.org/downloads/ and try again.
  pause
)
