#!/bin/sh

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$SCRIPT_DIR/tmux_clipboard_env.sh"

paste_from_clipboard | tmux load-buffer -
tmux paste-buffer
