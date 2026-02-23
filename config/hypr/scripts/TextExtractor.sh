#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Text Extractor with tesseract

notify-send "Text Extractor" "Select area to extract text" -i "text-x-generic"

# Check if dependencies are installed
if ! command -v tesseract &> /dev/null; then
  notify-send "Error" "tesseract is not installed." -u critical
  exit 1
fi

if ! command -v grim &> /dev/null; then
  notify-send "Error" "grim is not installed." -u critical
  exit 1
fi

if ! command -v slurp &> /dev/null; then
  notify-send "Error" "slurp is not installed." -u critical
  exit 1
fi

# OCR Logic
grim -g "$(slurp)" - | tesseract - - -l eng | wl-copy

if [ $? -eq 0 ]; then
  notify-send "Text Extractor" "Text copied to clipboard!" -i "edit-copy"
else
  notify-send "Text Extractor" "Failed to extract text." -u critical
fi
