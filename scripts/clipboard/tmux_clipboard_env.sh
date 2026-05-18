#!/bin/sh

display_error() {
  printf '%s\n' "$1" >&2
  if [ -n "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
    tmux display-message "$1"
  fi
}

is_wsl() {
  grep -qi microsoft /proc/version 2>/dev/null
}

set_clipboard_env() {
  if [ -n "$TMUX_CLIPBOARD_BACKEND" ]; then
    export TMUX_CLIPBOARD_BACKEND
    return 0
  fi

  if command -v pbcopy >/dev/null 2>&1 && command -v pbpaste >/dev/null 2>&1; then
    TMUX_CLIPBOARD_BACKEND=macos
  elif is_wsl && command -v clip.exe >/dev/null 2>&1 && command -v powershell.exe >/dev/null 2>&1; then
    TMUX_CLIPBOARD_BACKEND=wsl
  elif command -v wl-copy >/dev/null 2>&1 && command -v wl-paste >/dev/null 2>&1; then
    TMUX_CLIPBOARD_BACKEND=wayland
  elif command -v xsel >/dev/null 2>&1; then
    TMUX_CLIPBOARD_BACKEND=xsel
  elif command -v xclip >/dev/null 2>&1; then
    TMUX_CLIPBOARD_BACKEND=xclip
  else
    display_error "No supported clipboard command found"
    return 1
  fi

  export TMUX_CLIPBOARD_BACKEND
}

copy_to_clipboard() {
  set_clipboard_env || return 1

  case "$TMUX_CLIPBOARD_BACKEND" in
    macos)
      pbcopy
      ;;
    wsl)
      clip.exe
      ;;
    wayland)
      wl-copy
      ;;
    xsel)
      xsel --clipboard --input
      ;;
    xclip)
      xclip -selection clipboard
      ;;
    *)
      display_error "Unsupported clipboard backend: $TMUX_CLIPBOARD_BACKEND"
      return 1
      ;;
  esac
}

paste_from_clipboard() {
  set_clipboard_env || return 1

  case "$TMUX_CLIPBOARD_BACKEND" in
    macos)
      pbpaste
      ;;
    wsl)
      powershell.exe -NoProfile -Command "[Console]::Out.Write((Get-Clipboard -Raw))" | tr -d '\r'
      ;;
    wayland)
      wl-paste --no-newline
      ;;
    xsel)
      xsel --clipboard --output
      ;;
    xclip)
      xclip -selection clipboard -o
      ;;
    *)
      display_error "Unsupported clipboard backend: $TMUX_CLIPBOARD_BACKEND"
      return 1
      ;;
  esac
}
