#!/usr/bin/env fish

if ! command -qs wezterm
    exit
end

wezterm shell-completion --shell fish > ~/.config/fish/completions/wezterm.fish

# Install terminfo
set -l tempfile (mktemp)
curl -o $tempfile https://raw.githubusercontent.com/wez/wezterm/master/termwiz/data/wezterm.terminfo
tic -x -o ~/.terminfo $tempfile
rm $tempfile
