# 個人用Zsh設定

macOSを中心に使用している個人用のZsh設定です。学生用の簡素な設定は`codex/student-macstudio`ブランチで管理しています。

## 導入

```sh
git clone git@github.com:niyaton/zsh.git
cd zsh
zsh setup.sh
exec zsh
```

`setup.sh`は、このリポジトリの`zsh/`と`zshrc`へのシンボリックリンクをHOMEに作ります。既存のシンボリックリンクは置き換えるため、繰り返し実行できます。通常ファイルやディレクトリがすでに存在する場合は、上書きせずエラーで停止します。色設定はリポジトリ内の`Dracula.dircolors`を直接読み込むため、`~/.dircolors`は不要です。

## 主な構成

- `zsh/00_path.zsh`: HomebrewなどのPATH
- `zsh/01_base.zsh`: 補完、キー操作、基本オプション
- `zsh/alias.zsh`: alias
- `zsh/dircolors.zsh`: 色設定のキャッシュと更新
- `zsh/editor.zsh`: 既定エディタの選択と`vim`のalias
- `zsh/functions.zsh`: 汎用関数
- `zsh/history.zsh`: 履歴と検索
- `zsh/prompt.zsh`: Git・Python環境を表示するプロンプト
- `zsh/tmux.zsh`: tmux補助関数
- `zshrc`: 各設定の読み込みと任意ツールの初期化

## 任意の依存ツール

設定は、ツールが存在する場合だけ連携機能を有効にします。

- Homebrew / GNU coreutils: 色付き`ls`と`dircolors`
- mise: PythonやNode.jsなどのruntime管理
- tmux: WezTerm外での自動接続
- fzf: `fd`関数によるディレクトリ選択
- zstd: `tz`、`zstdrm`関数
- Neovim: `EDITOR`、`VISUAL`、`vim` alias

## よく使う独自関数

```sh
fd [開始ディレクトリ] # fzfで移動先を選択
tz DIR                 # DIR.tar.zstを作成
zstdrm FILE.zst        # 展開成功後に圧縮ファイルを削除
update_zshrc           # Zsh設定をコンパイル
update_dircolors       # Dracula.dircolors変更後に色設定を再生成・反映
```

設定変更後は、新しいシェルを開始します。

色設定はOS・端末種別（`TERM`）ごとにキャッシュし、通常の起動では読み込むだけです。
リポジトリ内の`Dracula.dircolors`を変更したら`update_dircolors`を実行してください。
現在の端末種別と既存キャッシュの端末種別を、そのコマンドの実行中だけ`TERM`を切り替えてまとめて再生成します。現在のシェルの`ls`と補完用の色にも反映します。

```sh
exec zsh
```

## 学生用設定

Mac Studioの学生アカウント向け設定は、個人用依存関係を除去した別ブランチにあります。

```sh
git switch codex/student-macstudio
```

学生用ブランチではPowerline FontやNerd Fontを必要とせず、ASCIIだけのプロンプトを使用します。
