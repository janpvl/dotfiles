#!/usr/bin/env bash
set -euo pipefail

# ===== Settings =====
MODE="cd"  # cd | window | session

# ===== Bookmarks =====
declare -A BOOKMARKS=(
  ["Home"]="$HOME"
  ["StudyApp"]="$HOME/dev/StudyApp/"
  ["dev/"]="$HOME/dev/"
  ["chess"]="$HOME/dev/chess-raylib/"
)

# ===== Helpers =====
sanitize_name() {
  local n="$1"
  echo "${n//[^a-zA-Z0-9_-]/_}"
}

require_tmux() {
  if ! command -v tmux >/dev/null 2>&1; then
    echo "tmux not installed." >&2
    exit 1
  fi

  if [[ -z "${TMUX:-}" ]]; then
    echo "Dieses Skript muss für MODE=\"$MODE\" innerhalb einer tmux-Session laufen." >&2
    exit 1
  fi
}

# ===== Auswahltool =====
if command -v sk >/dev/null 2>&1; then
  PICKER=(sk --margin 10% --color=bw --bind 'q:abort')
elif command -v fzf >/dev/null 2>&1; then
  PICKER=(fzf --height 40% --reverse --bind 'esc:abort')
else
  echo "Bitte skim (sk) oder fzf installieren." >&2
  exit 1
fi

# ===== Selection =====
mapfile -t sorted_labels < <(printf "%s\n" "${!BOOKMARKS[@]}" | sort)
choice="$(printf "%s\n" "${sorted_labels[@]}" | "${PICKER[@]}")" || exit 0
target_dir="${BOOKMARKS[$choice]:-}"

# ===== Validation =====
if [[ -z "$target_dir" || ! -d "$target_dir" ]]; then
  echo "Ungültiger Pfad: $target_dir" >&2
  exit 1
fi

# ===== Action =====
case "$MODE" in
  cd)
    require_tmux
    pane_id="$(tmux display-message -p '#{pane_id}')"
    tmux send-keys -t "$pane_id" "cd \"$target_dir\"" C-m
    tmux send-keys -t "$pane_id" C-l

    ;;
  window)
    require_tmux
    tmux new-window -c "$target_dir" -n "$(sanitize_name "$choice")"
    ;;
  session)
    require_tmux
    session_name="$(sanitize_name "$choice")"

    if tmux has-session -t "$session_name" 2>/dev/null; then
      tmux switch-client -t "$session_name"
    else
      tmux new-session -ds "$session_name" -c "$target_dir"
      tmux switch-client -t "$session_name"
    fi
    ;;
  *)
    echo "Unknown MODE: $MODE" >&2
    exit 1
    ;;
esac
