# 個人用Zsh設定

macOSを中心に使用している個人用のZsh設定です。学生用の簡素な設定は`codex/student-macstudio`ブランチで管理しています。

## 導入

```sh
git clone git@github.com:niyaton/zsh.git
cd zsh
./setup.sh
exec zsh
```

`setup.sh`は、このリポジトリの`zsh/`、`zshrc`、`Dracula.dircolors`へのシンボリックリンクをHOMEに作ります。既存ファイルがある場合は、削除せず日時と識別番号付きの`.backup-*`へ退避します。同じリポジトリに対して再実行しても既存リンクはそのまま利用します。

## 主な構成

- `zsh/00_path.zsh`: HomebrewなどのPATH
- `zsh/01_base.zsh`: 補完、キー操作、色、エディタ
- `zsh/alias.zsh`: alias
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
```

設定変更後は、新しいシェルを開始します。

```sh
exec zsh
```

## 学生用設定

Mac Studioの学生アカウント向け設定は、個人用依存関係を除去した別ブランチにあります。

```sh
git switch codex/student-macstudio
```

学生用ブランチではPowerline FontやNerd Fontを必要とせず、ASCIIだけのプロンプトを使用します。
