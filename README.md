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
- `sudo`: some configurations may need that

### Install

```console
git clone git@github.com:leandro-lugaresi/dotfiles.fish.git ~/.dotfiles
cd ~/.dotfiles
./script/bootstrap.sh
```

This will install Homebrew (if needed), all dependencies (CLI tools, casks, fonts), and start required services.

### Sync configs

After bootstrapping, or whenever you want to update symlinks and configs:

```console
./script/sync.fish
```

This sets up git config, symlinks all dotfiles, installs fish plugins, and sets fish as the default shell.

> All changed files are backed up with a `.backup` suffix.

### macOS defaults

Apply macOS system preferences (Finder, Dock, keyboard, trackpad, etc.):

```console
./macos/set-defaults.sh
```

Log out and back in (or restart) for all changes to take effect.

### Update

To update, pull the latest changes and re-run sync:

```console
cd ~/.dotfiles
git pull origin main
./script/sync.fish
```

## Revert

Reverting is not totally automated, but it pretty much consists in removing the
fish configuration and the `.dotfiles` folder, as well as moving back some other
configuration files:

```console
rm -rf ~/.dotfiles $__fish_config_dir
```

The sync script created a bunch of symbolic links that are now invalid.
You will have to investigate those manually. In cases a file already existed,
the `script/sync.fish` script should have created a `.backup` file with
the same name.

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
