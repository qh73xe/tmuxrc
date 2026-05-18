#!/bin/sh

display_error() {
  printf '%s\n' "$1" >&2
  if [ -n "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
    tmux display-message "$1"
  fi
}

display_info() {
  printf '%s\n' "$1"
  if [ -n "$TMUX" ] && command -v tmux >/dev/null 2>&1; then
    tmux display-message "$1"
  fi
}

exec_first_available() {
  while [ "$#" -gt 0 ]; do
    if command -v "$1" >/dev/null 2>&1; then
      display_info "launch llm: $1"
      exec "$1"
    fi
    shift
  done

  return 1
}

prompt_install_copilot() {
  printf "No LLM CLI found. Install copilot now? [y/N] "
  read -r answer

  case "$answer" in
    y|Y)
      return 0
      ;;
    *)
      display_error "llm command not found: tried cursor-cli, copilot, codex, gemini"
      return 1
      ;;
  esac
}

install_copilot() {
  if ! command -v npm >/dev/null 2>&1; then
    display_error "npm not found: cannot install copilot"
    return 1
  fi

  display_info "installing copilot via npm"
  npm install -g @github/copilot || return 1

  if ! command -v copilot >/dev/null 2>&1; then
    display_error "copilot installed but not found in PATH"
    return 1
  fi

  display_info "launch llm: copilot"
  exec copilot
}

exec_first_available \
  cursor-cli \
  copilot \
  codex \
  gemini && exit 0

prompt_install_copilot || exit 1
install_copilot
