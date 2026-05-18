#!/bin/sh
fname=~/.tmuxinator/$1.yml
if [ -e $fname ]; then
   vim $fname
else
   mux open $1
fi
