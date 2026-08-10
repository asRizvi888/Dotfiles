# Dotfiles

Personal macOS dotfiles, managed with a single `setup.sh` that symlinks configs into place and installs everything via Homebrew Bundle.

## What's included

| Tool | Config |
| --- | --- |
| [Homebrew](https://brew.sh) | `.config/homebrew/Brewfile` |
| [Zsh](https://www.zsh.org/) | `.config/zsh/.zshrc`, `.zshenv` |
| [Starship](https://starship.rs) prompt | `.config/starship/config.toml` |
| [Neovim](https://neovim.io) ([LazyVim](https://www.lazyvim.org)) | `.config/nvim` |
| [Ghostty](https://ghostty.org) terminal | `.config/ghostty/config` |
| [tmux](https://github.com/tmux/tmux) | `.config/tmux/tmux.conf` |
| Vim (fallback) | `.vimrc` |

Packages installed via `brew bundle` (see `.config/homebrew/Brewfile` for the full list): `gh`, `git`, `starship`, `neovim`, `fzf`, `ripgrep`, `fd`, `lazygit`, `tmux`, `node`, `python`, `go`, `pnpm`, plus the `ghostty` cask and JetBrains Mono Nerd Font.

## Prerequisites

- macOS
- Xcode Command Line Tools (installed automatically by the Homebrew installer below if missing)

## 1. Install Homebrew

Skip this step if `brew --version` already works.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

After it finishes, the installer prints a step to add Homebrew to your `PATH` — run the command it shows you (it differs for Apple Silicon vs Intel), e.g.:

```bash
# Apple Silicon
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Intel
echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/usr/local/bin/brew shellenv)"
```

Verify:

```bash
brew --version
```

> **Note:** `setup.sh` and `.zshrc` in this repo assume Homebrew lives at `/usr/local` (Intel path). If you're on Apple Silicon (`/opt/homebrew`), update the `eval "$(/usr/local/bin/brew shellenv)"` line in `.config/zsh/.zshrc` to `/opt/homebrew/bin/brew` after installing.

## 2. Clone this repo

`setup.sh` hardcodes the path `~/Dotfiles`, so clone it there:

```bash
git clone https://github.com/asRizvi888/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles
```

## 3. Run setup

```bash
./setup.sh
```

This will:

1. Create `~/.config` if it doesn't exist.
2. Symlink `ghostty`, `nvim`, `homebrew`, `zsh`, `starship`, and `tmux` configs into `~/.config`.
3. Symlink `.zshenv` and `.vimrc` into `$HOME`.
4. Run `brew bundle --file="$HOME/Dotfiles/.config/homebrew/Brewfile"` to install all CLI tools, casks, and fonts.

## 4. Restart your terminal

`.zshenv` sets `ZDOTDIR="$HOME/.config/zsh"`, which points Zsh at `.config/zsh/.zshrc`. macOS has used Zsh as the default login shell since Catalina, so no `chsh` needed unless you'd previously switched to something else (`chsh -s $(command -v zsh)` if so).

Restart your terminal (or open Ghostty, which was just installed) to pick up the new config.

## 5. Post-install checks

```bash
nvim   # first launch bootstraps LazyVim plugins automatically
tmux   # prefix key is Ctrl-a (not the default Ctrl-b)
starship --version
```

- Neovim: LazyVim plugins install automatically on first launch. Restart Neovim once they finish.
- Ghostty: open the app and confirm the font renders as **JetBrainsMono Nerd Font** — if not, set it manually in `.config/ghostty/config` or the app's settings.
- tmux reload after edits: `prefix + r` (i.e. `Ctrl-a` then `r`).

## Optional / machine-specific

`.config/zsh/.zshrc` also sets a few paths that only apply if you have these tools installed — edit or remove the ones you don't need:

```bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
```

## Updating

Pull the latest changes and re-run setup (symlinks are idempotent, `brew bundle` only installs what's missing):

```bash
cd ~/Dotfiles && git pull && ./setup.sh
```

## Adding a new package

Add a line to `.config/homebrew/Brewfile` (`brew "name"` or `cask "name"`), then run:

```bash
brew bundle --file="$HOME/Dotfiles/.config/homebrew/Brewfile"
```
