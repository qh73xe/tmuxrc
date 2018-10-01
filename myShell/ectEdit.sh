#! /bin/sh
help='
# 使い方
## 設定できるファイル
- vim : vim 設定の編集
- zsh : zsh 設定の編集
- tmux: : tmux 設定の編集

## git の操作
- gut_pull : myect を pull します
- gut_push : myect を ゴニョゴニョした後 push します
- gut_graph : myect を の状態を示します
'

if [ $1 = 'vim' ]; then
   vim ~/Documents/ect/vim/vimrc
elif [ $1 = 'zsh' ]; then
   vim ~/Documents/ect/zsh/zshrc
elif [ $1 = 'vimp' ]; then
   vim ~/Documents/ect/firefox/.vimperatorrc
elif [ $1 = 'tmux' ]; then
   vim ~/Documents/ect/tmux/tmux.conf
elif [ $1 = 'mutt' ]; then
   vim ~/Documents/ect/mutt/muttrc
elif [ $1 = 'css' ]; then
   vim ~/Documents/ect/sphinx/_static/custom.css
elif [ $1 = 'git_pull' ]; then
   git pull origin master | less
elif [ $1 = 'git_push' ]; then
   cd ~/Documents/ect
   git add .
   git commit
   git push origin master | less
elif [ $1 = 'git_graph' ]; then
   cd ~/Documents/ect
   git graph
elif [ $1 = 'help' ]; then
   cd ~/Documents/ect
   echo "$help" | pandoc | w3m -T text/html
fi

