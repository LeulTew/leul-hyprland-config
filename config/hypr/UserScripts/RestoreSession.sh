#!/usr/bin/env bash
# /* ---- 💫 RestoreSession.sh 💫 ---- */
# Restores open windows from ~/.config/hypr/session.json
# Called on Hyprland startup (exec-once) or manually

SESSION_FILE="$HOME/.config/hypr/session.json"
LOG_FILE="/tmp/hypr_restore.log"

echo "=== Session Restore Started at $(date) ===" > "$LOG_FILE"

[[ ! -f "$SESSION_FILE" ]] && echo "No session file found." >> "$LOG_FILE" && exit 0

# Map window class → launch command
get_exec() {
  local class="$1"
  case "${class,,}" in
    kitty)                          echo "kitty" ;;
    firefox|firefox-esr)            echo "firefox" ;;
    "zen browser"|zen|zen-alpha)    echo "flatpak run app.zen_browser.zen" ;;
    dolphin|org.kde.dolphin)        echo "dolphin" ;;
    "code - insiders"|code-insiders) echo "code-insiders" ;;
    code|"visual studio code")      echo "code" ;;
    spotify)                        echo "flatpak run com.spotify.Client" ;;
    notion-desktop)                 echo "snap run notion-desktop --disable-gpu" ;;
    thunar)                         echo "thunar" ;;
    telegram-desktop|telegram)      echo "telegram-desktop" ;;
    discord)                        echo "discord" ;;
    slack)                          echo "slack" ;;
    obs)                            echo "obs" ;;
    gimp)                           echo "gimp" ;;
    vlc)                            echo "vlc" ;;
    *)                              echo "$class" ;;
  esac
}

LAUNCHED=0

jq -rc '.[]' "$SESSION_FILE" | while IFS= read -r entry; do
  CLASS=$(echo "$entry" | jq -r '.class')
  WS=$(echo "$entry" | jq -r '.workspace')

  # Filter out invalid workspaces or classes
  if [[ "$WS" == "null" ]] || [[ -z "$WS" ]]; then
      echo "Skipping $CLASS: No workspace defined" >> "$LOG_FILE"
      continue
  fi

  CMD=$(get_exec "$CLASS")
  if [[ -z "$CMD" ]]; then
      echo "Skipping $CLASS: No command found" >> "$LOG_FILE"
      continue
  fi

  # Skip if app is already running
  if pgrep -fi "$(echo "$CMD" | awk '{print $1}')" > /dev/null 2>&1; then
      echo "Skipping $CLASS: Already running" >> "$LOG_FILE"
      continue
  fi

  echo "Restoring $CLASS ($CMD) to Workspace $WS" >> "$LOG_FILE"

  # Launch on the saved workspace silently
  # Using 'hyprctl dispatch exec ...' with specific rules
  hyprctl dispatch exec "[workspace ${WS} silent] $CMD" >> "$LOG_FILE" 2>&1 &
  
  sleep 1.5  # Increased delay to ensure Hyprland registers the rule
  LAUNCHED=$((LAUNCHED + 1))
done

sleep 2
notify-send "Session Restored" "Windows relaunched on saved workspaces" --icon=preferences-system-windows -t 2000
echo "=== Session Restore Completed ===" >> "$LOG_FILE"
