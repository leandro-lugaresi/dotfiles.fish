# Repository Guidelines

## Purpose

Personal macOS dotfiles for Fish, Homebrew, editors, terminals, Git, and system tools.

## Setup Flow

- `./script/bootstrap.sh` installs Homebrew dependencies from `Brewfile`.
- `./script/sync.fish` links configs into `$HOME` and `~/.config`, installs Fish plugins, and runs every `*/install.fish` module.
- `./macos/set-defaults.sh` applies macOS preferences separately.

## Dotfile Patterns

- `module/name.symlink` links to `~/.name` via `script/sync.fish`.
- Directory configs that belong under `~/.config` should be linked explicitly in `script/sync.fish`.
- Module-specific setup belongs in `module/install.fish`.
- Fish functions live in `module/functions/`.
- Fish startup snippets live in `module/conf.d/*.fish`.

## Package Management

- Add Homebrew formulae, casks, and taps to `Brewfile`.
- Keep `script/bootstrap.sh` as orchestration only; avoid adding repeated `brew install` calls.
- Use fully qualified tapped casks when needed, for example `cask "nikitabobko/tap/aerospace"`.

## Verification

- Check Bash scripts with `bash -n path/to/script.sh`.
- Check Fish scripts with `fish -n path/to/script.fish`.
- Check Homebrew dependencies with `brew bundle check --file=Brewfile`.
- Do not run destructive sync/bootstrap changes unless requested.

## Git

- Stage specific files only; do not use `git add .` or `git add -A`.
- Leave unrelated local changes untouched.
- Use conventional commit messages, for example `feat: add zed setup`.
- Commits may require local GPG passphrase entry.
