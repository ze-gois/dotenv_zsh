pass weechat/passphrase
tmux new-session -d -s weechat 'export WEECHAT_PASSPHRASE="$(pass show weechat/passphrase)" weechat'
