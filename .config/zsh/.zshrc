# SET alias for quick access

alias md="mkdir -p"

# VIM keybinding

bindkey -v
KEYTIMEOUT=1


# Tell Starship exactly where your custom config file lives
export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"

# Initialize starship prompt
eval "$(starship init zsh)"

# FZF navigation

fz() {
  local result
  
  # Ensure fd exists
  if command -v fd >/dev/null 2>&1; then
    # -H shows hidden files, -I includes items listed in .gitignore
    result=$(fd --type f --type d --hidden --no-ignore --exclude .git . 2>/dev/null | fzf \
      --preview 'if [ -d {} ]; then ls -A -p -C {} 2>/dev/null; else head -n 100 {} 2>/dev/null; fi')
  else
    # Fallback native Mac find command including dotfiles
    result=$(find . -maxdepth 4 2>/dev/null | fzf \
      --preview 'if [ -d {} ]; then ls -A -p -C {} 2>/dev/null; else head -n 100 {} 2>/dev/null; fi')
  fi

  # Exit cleanly if ESC or Ctrl+C is hit
  [ -z "$result" ] && return

  # Smart Destination Selection
  if [ -d "$result" ]; then
    cd "$result" || return
  elif [ -f "$result" ]; then
    if command -v nvim >/dev/null 2>&1; then
      nvim "$result"
    else
      vi "$result"
    fi
  fi
}

# Claude Code path
export PATH="$HOME/.local/bin:$PATH"

# Homebrew environment: puts /usr/local/bin ahead of /usr/bin so brew's git wins
eval "$(/usr/local/bin/brew shellenv)"

# Homebrew's completion scripts
fpath=(/usr/local/share/zsh/site-functions $fpath)

# Completion engine, -i loads dirs instead of silently skipping on the permission check
autoload -Uz compinit
compinit -i
