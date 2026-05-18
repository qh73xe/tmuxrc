#! /bin/sh

show_mainmenu()
{
  while true; do
    cat <<EOF
setting ect
1: proj
2: prod
3: toolManual
4: workingLog
5: readingBooks
6: cancel
数字を入力してください
EOF
    # キー入力をACT_MAINに代入
    read ACT_MAIN
    # キー入力された値によって分岐
    case ${ACT_MAIN} in
     1)
      vifm ~/Documents/proj
      break
      ;;
     2)
      vifm ~/Documents/product
      break
      ;;
     3)
      vifm ~/Documents/toolsManual
      break
      ;;
     4)
      vifm ~/Documents/workinglog
      break
      ;;
     5)
      vifm ~/Documents/reading
      break
      ;;
     6)
      break
      ;;
     *)
      printf "エラー: 無効な項目 \"%s\" が入力されました\n" "${ACT_MAIN}"
      ;;
    esac
  done
}

show_gitMenu()
{
  while true; do
    cat <<EOF
What do you want to do git ?
1: git pull
2: git push
3: git graph
4: Return <ect setting>
数字を入力してください
EOF
    read ACT_SUB1
    case ${ACT_SUB1} in
     1)
      cd ~/Documents/ect
      git pull origin master | less
      break
      ;;
     2)
      cd ~/Documents/ect
      git add .
      git commit
      git push origin master | less
      break
      ;;
     3)
      cd ~/Documents/ect
      git graph
      break
      ;;
     4)
      show_mainmenu
      break
      ;;
     *)
      printf "エラー: 無効な項目 \"%s\" が入力されました\n" "${ACT_SUB1}"
      ;;
    esac
  done
}

# ここから処理開始
show_mainmenu
