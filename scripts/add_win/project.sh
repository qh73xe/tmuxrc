#!/bin/bash
PROJECRROOT=$HOME/Documents/proj/${1}
DOCUMENTROOT=$PROJECRROOT/doc

if [ -e $PROJECRROOT ]; then
    tmux new-window -n ${1} -c $PROJECRROOT
    tmux select-window -t ${1}

    if [ ! -e $DOCUMENTROOT ]; then
        mkdir $DOCUMENTROOT
        tmux split-window -t ${1} "sphinx-quickstart $DOCUMENTROOT"
    fi

    tmux split-window -t ${1} "ranger $PROJECRROOT"
    tmux select-layout -t ${1} main-horizontal
else
    mkdir $PROJECRROOT
    mkdir $DOCUMENTROOT

    tmux new-window -n ${1} -c $PROJECRROOT
    tmux select-window -t ${1}
    tmux split-window -t ${1} "sphinx-quickstart $DOCUMENTROOT"
    tmux split-window -t ${1} "ranger $PROJECRROOT"
    tmux select-layout -t ${1} main-horizontal
fi
