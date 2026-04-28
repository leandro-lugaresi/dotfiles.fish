#!/usr/bin/env bash
set -euo pipefail

DOTFILES_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"

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

if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

brew analytics off

echo "Installing Brew bundle..."
brew bundle --file="$DOTFILES_ROOT/Brewfile"

# Installing Fonts
git clone git@github.com:shaunsingh/SFMono-Nerd-Font-Ligaturized.git /tmp/SFMono_Nerd_Font
mv /tmp/SFMono_Nerd_Font/* "$HOME/Library/Fonts"
rm -rf /tmp/SFMono_Nerd_Font/

echo "Installation complete..."
