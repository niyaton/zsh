# Zsh整備の引き継ぎ

- 個人用は `main`。Mac Studioの学生配布用は `codex/student-macstudio` で、導入ガイドもそちらにある。
- 変更は一項目ずつ本人のレビューを通し、依頼された範囲をコミットする。Gitは `/opt/homebrew/bin/git` を使う。pushは本人がまとめて行う。

## 運用メモ

- `00_path.zsh` のHomebrew設定はApple Siliconの `/opt/homebrew` を前提とする。導入時や更新後に `brew --prefix`、`brew --cellar`、`brew --repository` を確認し、必要に応じて `PATH=/usr/bin:/bin:/usr/sbin:/sbin /opt/homebrew/bin/brew shellenv zsh` と比較する。コマンド検索は個人用と `/usr/local` をHomebrewより前に置き、manページも `/usr/local` を優先する。補完はmacOS付属が先。
- 色設定はリポジトリ内の `Dracula.dircolors` を使う。OS・TERM別の生成物は `zsh/.cache/dircolors/` に置く。色を変えたら `update_dircolors`。既存の端末種別もまとめて再生成する。
- `fcd` はfzfで移動先を選ぶ。 `tz DIR` はtar＋zstdで圧縮し、渡したパスの階層を保持する。 `zstdrm -d FILE.zst` は展開後に元ファイルを削除する。圧縮時の元ファイル削除には `zstdrm FILE`。 `update_zshrc` は設定のコンパイル用。
- Ctrl-P／Ctrl-Nは入力済みの接頭辞で履歴を前後に検索する。Neovimがあれば既定エディタにする。miseは起動時に有効化し、tmuxはWezTerm外の対話シェルで条件付き自動接続する。

## レビューの続き

- SSHのTab補完は `8fd9aac`、`ssh-list`・`ssh-pick` と `zsh/ssh-list.py` は `63c3139` でコミット済み。Pythonで明示的なHost名を一覧にし、fzfで選択して接続できる。一覧は通信や `Match exec` を実行せず、対応外の `Include` や `Match` 形式はエラーにする。Tab補完側は標準実装由来の循環Includeを検出しない。
- プロンプトのGit表示は以前このリポジトリで約70ms。ブランチ・変更状態・操作状態を保ちながらGit呼び出しをまとめる案は未実装。
- `tz` はパイプ途中の失敗を返すが、不完全な出力が残り得る。
- MacからDockerは削除済み。 `docker.zsh` はLinux側で使っているか確認してから判断する。GPG関数はageで代替できるか検討するため `WIP: GPG helpers (consider age instead)` のstashに退避済み。

# References
* dircolors: https://github.com/joshbenham/linux-dotfiles/blob/master/dircolors/Dracula.dircolors

# Pending review
* `zshrc`のWezTerm直前コマンド・出力コピー用フック（コミット`956adb7`）は重要な機能として維持する。最後の`zshrc`レビューで読み込み位置・条件・外部ファイルへの依存を整理する。コミット済みであることは確認・了承済み（2026-09-26）。
