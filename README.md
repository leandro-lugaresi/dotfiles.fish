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

- [`Ghostty`](https://github.com/ghostty-org/ghostty) a fast, cross-platform terminal emulator;
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

_Catppuccin_ and _IosevkaTerm_ Font.

The system is set up to automatically switch between dark and light modes based on the current system configuration. Additionally, tools such as Ghostty, Neovim, and Fish include automated checks that adjust their appearance according to the macOS settings.

## Screenshots

### neovim with LSP, git signs, etc

![image](https://github.com/user-attachments/assets/d67fef29-bb89-49cc-939d-2f70f3b0b8f7)

### neovim telescope

![image](https://github.com/user-attachments/assets/ce3d785f-e71f-45e5-a2a8-909b51773462)

### tmux-sessionizer and tmux tabs with icons

![image](https://github.com/user-attachments/assets/e9eceaea-7f70-468f-9af6-d75d6b6a8fcb)

### dark theme and light theme
![image](https://github.com/user-attachments/assets/7e043310-a243-4565-ba39-6bf0a43c146e)
![image](https://github.com/user-attachments/assets/8273cfa6-6b48-45c2-ac21-e3e444475af2)


