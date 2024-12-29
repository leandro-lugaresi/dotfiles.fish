#!/usr/bin/env fish
if ! command -qs tmux
    exit
end

test -d ~/.tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if command -qs tms
    tms config --full-path false --paths $PROJECTS $DOTFILES --search-submodules false --max-depths 5 --picker-highlight-color="#181825" --picker-highlight-text-color="#ffffff"
end

alias --save ta='tmux-new'
