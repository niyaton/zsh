# Zsh整備の引き継ぎ

- 個人用Macは `main`、個人用Linuxは `linux`（worktreeは `~/work/zsh-linux`）。Mac Studioの学生配布用は `codex/student-macstudio` で、導入ガイドもそちらにある。
- 共通の修正は `main` に入れ、OS固有の差分とは別のコミットにする。`linux` には必要な共通コミットを `cherry-pick` し、履歴を組み替えてよい場合は `rebase` で追従させる。
- 変更は一項目ずつ本人のレビューを通し、依頼された範囲をコミットする。Gitは `/opt/homebrew/bin/git` を使う。pushは本人がまとめて行う。

## 運用メモ

- `00_path.zsh` のHomebrew設定はApple Siliconの `/opt/homebrew` を前提とする。導入時や更新後に `brew --prefix`、`brew --cellar`、`brew --repository` を確認し、必要に応じて `PATH=/usr/bin:/bin:/usr/sbin:/sbin /opt/homebrew/bin/brew shellenv zsh` と比較する。コマンド検索は個人用と `/usr/local` をHomebrewより前に置き、manページも `/usr/local` を優先する。補完はmacOS付属が先。
- 色設定はリポジトリ内の `Dracula.dircolors` を使う。OS・TERM別の生成物は `zsh/.cache/dircolors/` に置く。色を変えたら `update_dircolors`。既存の端末種別もまとめて再生成する。
- `fcd` はfzfで移動先を選ぶ。 `tz DIR` はtar＋zstdで圧縮し、渡したパスの階層を保持する。 `zstdrm -d FILE.zst` は展開後に元ファイルを削除する。圧縮時の元ファイル削除には `zstdrm FILE`。 `update_zshrc` は設定のコンパイル用。
- Ctrl-P／Ctrl-Nは入力済みの接頭辞で履歴を前後に検索する。Macの既定エディタはNeovimで、`doctor.zsh` が必須コマンドとして確認する。Linuxでは `attach-tmux` を手動で呼び出せる。
- Macのfzf連携はリポジトリのルートで `fzf --zsh > zsh/fzf.zsh` として生成する。生成物はGitの管理外で、見つからない場合は `doctor.zsh` が生成コマンドを案内する。
- miseが入っている場合、対話シェルの起動時に `01_mise.zsh` で有効化コードの生成を始め、`zz_mise.zsh` で適用する。
- WezTermで直前のコマンドと出力をコピーするフックは `integrations.zsh` にある。WezTerm内の対話シェルで、tmuxの外にいて `~/work/wezterm/shell/copy-last-command.zsh` が読み取れる場合に読み込む。

## レビューの続き

- SSHのTab補完は `8fd9aac`、`ssh-list`・`ssh-pick` と `zsh/ssh-list.py` は `63c3139` でコミット済み。Pythonで明示的なHost名を一覧にし、fzfで選択して接続できる。一覧は通信や `Match exec` を実行せず、対応外の `Include` や `Match` 形式はエラーにする。
- プロンプトのGit表示は以前このリポジトリで約70ms。ブランチ・変更状態・操作状態を保ちながらGit呼び出しをまとめる案は未実装。
- MacからDockerは削除済み。 `docker.zsh` はLinux側で使っているか確認してから判断する。GPG関数はageで代替できるか検討するため `WIP: GPG helpers (consider age instead)` のstashに退避済み。

# References
* dircolors: https://github.com/joshbenham/linux-dotfiles/blob/master/dircolors/Dracula.dircolors
