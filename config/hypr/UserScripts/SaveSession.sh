#!/usr/bin/env bash
# /* ---- 💫 SaveSession.sh 💫 ---- */
# Saves open windows + workspace assignments to ~/.config/hypr/session.json
# Bind this to Super+Shift+S or call before logout

SESSION_FILE="$HOME/.config/hypr/session.json"

hyprctl clients -j | jq '[
  .[] | select(.class != "" and .class != null) | {
    class:        .class,
    workspace:    .workspace.id,
    monitor:      .monitor,
    floating:     .floating
  }
] | unique_by(.class + (.workspace|tostring))' > "$SESSION_FILE"

SAVED=$(jq 'length' "$SESSION_FILE")
notify-send "Session Saved" "$SAVED windows saved to session.json" --icon=media-floppy -t 2000
