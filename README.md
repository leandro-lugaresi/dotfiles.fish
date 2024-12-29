<p align="center">
  <img alt="header image" src="https://raw.githubusercontent.com/leandro-lugaresi/dotfiles.fish/master/docs/header.svg" height="350" />
  <h2 align="center">Leandro' dotfiles</h2>
  <p align="center">Config files for Fish, Go, Editors, Terminals and more.</p>
</p>

---

Detatched fork from [caarlos0 dotfiles.fish](https://github.com/caarlos0/dotfiles.fish), thanks for this amazing repository.

## Installation

### Dependencies

First, make sure you have all the following installed:

- `git`: to clone the repository
- `curl`: to download files
- `tar`: to extract downloaded files
- `fish`: the shell
- `sudo`: some configurations may need that

### Install

Then, run these steps:

```console
git clone https://github.com/leandro-lugaresi/dotfiles.fish.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap.fish
```

> All changed files were backed up with a `.backup` suffix.

#### Update

To update, you need to `git pull` and run the bootstrap script again:

```console
cd ~/.dotfiles
git pull origin master
./script/bootstrap.fish
```

## Revert

Reverting is not totally automated, but it pretty much consists in removing the
fish configuration and the `.dotfiles` folder, as well as moving back some other
configuration files:

```console
rm -rf ~/.dotfiles $__fish_config_dir
```

The bootstrap script created a bunch of symbolic links that are now invalid.
You will have to investigate those manually. In cases a file already existed,
the `script/bootstrap.fish` script should have created a `.backup` file with
the same name.

## Recommended Software

- [`alacritty`](https://github.com/alacritty/alacritty) a cross-platform, OpenGL
  terminal emulator;
- [`bat`](https://github.com/sharkdp/bat) a cat(1) clone with wings;
- [`delta`](https://github.com/dandavison/delta) for better git diffs;
- [`fd`](https://github.com/sharkdp/fd) a simple, fast and user-friendly
  alternative to `find`;
- [`fzf`](https://github.com/junegunn/fzf) for a fuzzy-finder;
- [`gum`](https://github.com/charmbracelet/gum) A tool for glamorous shell
  scripts;
- [`gh`](https://github.com/cli/cli) for more GitHub integration with the
  terminal;
- [`grc`](https://github.com/garabik/grc) to colorize command's outputs;
- [`kubectx`](https://github.com/ahmetb/kubectx) for better Kubernetes context
  and namespaces switch;
- [`neovim`](https://neovim.io) extensible Vim-based text editor;
- [`starship.rs`](https://starship.rs) the shell prompt we are using;
- [`tms`](https://github.com/jrmoulton/tmux-sessionizer) A Tmux sessionizer

To install them all with `brew`:

```console
brew install \
  bat \
  eza \
  fd \
  fish \
  fzf \
  gh \
  git-delta \
  grc \
  kubectx \
  neovim \
  starship \
  zoxide \
  wezterm \
  ghostty \
  ripgrep \
  gpg2 \
  gnupg \
  pinentry-mac \
  overmind \
  watchexec
```

On Ubuntu:

```console
sh -c "$(curl -fsSL https://starship.rs/install.sh)"
sudo apt install fish grc fzf zoxide fd-find exa bat alacritty kitty neovim
# TODO: install delta, kubectx
```

After that, install the tmux-sessionizer:

```bash
cargo install tmux-sessionizer
```

## macOS defaults

You use it by running:

```console
~/.dotfiles/macos/set-defaults.sh
```

And logging out and in again or restart.

## Themes and fonts

_Catppuccin Mocha_ and _FiraCode_ Font.

## Screenshots

### neovim with LSP, git signs, etc

![CleanShot 2022-10-01 at 20 12 19@2x](https://user-images.githubusercontent.com/245435/193431550-5f279c3d-a0f6-4e67-81bc-1c1538fc71be.png)

### neovim telescope

![CleanShot 2022-10-01 at 20 12 34@2x](https://user-images.githubusercontent.com/245435/193431554-9ab32711-3eab-4d0e-8cec-f7b09713abf5.png)

### tmux-sessionizer and tmux tabs with icons

![CleanShot 2022-10-01 at 20 13 06@2x](https://user-images.githubusercontent.com/245435/193431556-8ee21015-8cde-44d0-93c2-ac3040a44057.png)
