tmux new-window -n haskell -c ./
tmux select-window -t haskell
tmux split-window -t haskell "ghci"
tmux select-layout -t haskell main-vertical
