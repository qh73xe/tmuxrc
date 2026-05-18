tmux new-window -n python -c ./
tmux select-window -t python
tmux split-window -t python "ipython"
# tmux select-layout main-horizontal
