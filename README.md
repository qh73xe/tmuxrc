# tmuxrc

tmux の設定はちょっと複雑化しているので,
レポジトリを分けて管理をします.

## 設定の適応方法

```
$ git clone https://github.com/erikw/tmux-powerline.git ~/.tmux/plugins/tmux-powerline
$ git clone git@github.com:qh73xe/tmuxrc.git ~/.config/tmux
$ cd ~/.config/tmux
$ ln ~/.config/tmux/tmux.conf ~/.tmux.conf
```

## 依存ツール

いくつかの設定は以下の外部コマンドを前提にします.

- <C-Space>pi : ipython
- <C-Space>g* : git, gh
- <C-Space>m  : cmus

## Keybind

```
<C=Space>  : Prefix
<C=Space>| : 縦方向に分割
<C=Space>- : 横方向に分割
<C-Space>h : 右のペインに移動
<C-Space>j : 下のベインに移動
<C-Space>k : 上のペインに移動
<C-Space>l : 左のペインに移動

<C-Space>m  : cmus (music player) を実行
<C-Space>pi : ipython を実行
<C-Space>gs : git status を実行
<C-Space>gc : 現在ディレクトリ以下の全ての変更を add した上で `git commit` を実施
<C-Space>gr : github レポジトリをブラウザで表示
<C-Space>gl : github レポジトリの issue 一覧を表示
<C-Space>gi : github レポジトリへ新規イシューを発行
```

# 設定系 TIPS

## shell スクリプトの実行方法に関して

shell コマンドの実行に関しては大きく実行場所によって書き方が変わる

### split-window: ペインを開いてコマンドを実施したい場合

`bind <key> split-window '<some command>'` を利用する.

この際に現在ペインのディレクトリを引き継ぎたい場合には
`split-window -c '#{pane_current_path}' '<some command>'` のオプションを付与する


### new-window: 新規ウインドウを開きコマンドを実行したい場合

`bind <key> new-window '<some command>'` を利用する

この際に現在ペインのディレクトリを引き継ぎたい場合には
`-c '#{pane_current_path}'` オプションを付与することは `split-window` と同じ

`new-window -d` のようにオプションを実施するとバックグラウンドで実行されるので便利


### send-keys: 現在ペインでコマンドを実行したい場合

`bind <key> send-keys '<cmd>'` を利用すると現在のペインに対しその文字を入力する.

これを応用し改行記号までを付与すれば現在ペインで直接コマンドを実行することになる.

- ただし, 文字列入力であることを考えると誤爆の危険はあるかも
- 使い道としては `git status` のように
  正常終了するコマンドを `tmux` で管理したい場合になるが
  それであれば普通にエイリアスで良い気もする.

## Key-bind を入れ子にする

コマンドを拡張するに当たって管理上
`vim` のように複数キーの連続で何かを発火させたくなる場合がある.
