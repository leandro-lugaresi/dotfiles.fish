#!/usr/bin/env fish
if ! command -qs tmux
    exit
end

test -d ~/.tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if command -qs tms
    tms config --full-path true --paths $PROJECTS $DOTFILES
end

alias --save ta='tmux-new'
