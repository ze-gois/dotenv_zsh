pass weechat/passphrase 1>/dev/null && tmux new-session -d -s weechat 'export WEECHAT_PASSPHRASE="$(pass show weechat/passphrase)" && weechat'
