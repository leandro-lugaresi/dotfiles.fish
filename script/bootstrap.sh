#!/usr/bin/env bash
set -euo pipefail

if [[ "$(uname)" != "Darwin" ]]; then
    exit 0
fi

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install 2>/dev/null || true

# Homebrew
## Install
if ! command -v brew &>/dev/null; then
    echo "Installing Brew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
brew analytics off

## Taps
echo "Tapping Brew..."
brew tap FelixKratz/formulae
brew tap jackielii/tap
brew tap asmvik/formulae

## Formulae
echo "Installing Brew Formulae..."
### Essentials
brew install bat
brew install eza
brew install fd
brew install fzf
brew install fnm
brew install gh
brew install git-delta
brew install gnupg
brew install ifstat
brew install jq
brew install pinentry-mac
brew install ripgrep
brew install skhd-zig
brew install yabai
brew install sketchybar
brew install borders
brew install switchaudio-osx
brew install wget

### Terminal
brew install fish
brew install grc
brew install neovim
brew install starship
brew install zoxide

### Nice to have
brew install btop
brew install chafa
brew install kubectx
brew install lazygit
brew install overmind
brew install rust
brew install svim
brew install tree-sitter-cli
brew install watchexec
brew install --cask spotify

## Casks
echo "Installing Brew Casks..."
### Terminals & Browsers
brew install --cask ghostty
brew install --cask wezterm
# brew install --cask zen

### Office
brew install --cask zoom
brew install --cask meetingbar
brew install --cask vlc

### Fonts
brew install --cask sf-symbols
brew install --cask font-hack-nerd-font
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-fira-code-nerd-font

# Installing Fonts
git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
mv /tmp/SFMono_Nerd_Font/* "$HOME/Library/Fonts"
rm -rf /tmp/SFMono_Nerd_Font/

curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.23/sketchybar-app-font.ttf -o "$HOME/Library/Fonts/sketchybar-app-font.ttf"

# Start Services
echo "Starting Services (grant permissions)..."
skhd --install-service
skhd --start-service
yabai --start-service

brew services start sketchybar
brew services start borders
brew services start svim

csrutil status
echo "Do not forget to disable SIP"
echo "Add sudoer manually:"
echo "  '$(whoami) ALL = (root) NOPASSWD: sha256:$(shasum -a 256 "$(which yabai)" | awk '{print $1}') $(which yabai) --load-sa' to '/private/etc/sudoers.d/yabai'"
echo "Installation complete..."
