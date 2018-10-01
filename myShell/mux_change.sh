#!/bin/sh
fname=~/.tmuxinator/$1.yml
if [ -e $fname ]; then
   tmux kill-session && mux $1
else
   mux open $1
fi
