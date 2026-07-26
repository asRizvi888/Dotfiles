#!/bin/bash
# ~/Dotfiles/setup.sh

echo "🚀 Starting dotfiles deployment..."

# 1. Ensure system config directory exists
mkdir -p "$HOME/.config"

# 2. Link individual configurations from the Git repo to ~/.config
# Formula: ln -sfn [Target/Actual File] [Link/Where it should appear]
ln -sfn "$HOME/Dotfiles/.config/ghostty"   "$HOME/.config/ghostty"
ln -sfn "$HOME/Dotfiles/.config/nvim"      "$HOME/.config/nvim"
ln -sfn "$HOME/Dotfiles/.config/homebrew"  "$HOME/.config/homebrew"
ln -sfn "$HOME/Dotfiles/.config/zsh"	   "$HOME/.config/zsh"

# 3. Link configurations that live outside of ~/.config (like tmux)
ln -sfn "$HOME/Dotfiles/.tmux.conf"        "$HOME/.tmux.conf"
ln -sfn "$HOME/Dotfiles/.zshenv" 	   "$HOME/.zshenv"		

echo "✅ Symbolic links created successfully!"

# 4. Run Homebrew Bundle using the newly linked Brewfile path
if command -v brew &> /dev/null; then
    echo "📦 Installing packages from Brewfile..."
    brew bundle --file="$HOME/Dotfiles/.config/homebrew/Brewfile"
else
    echo "⚠️ Homebrew not found. Install Homebrew first, then run 'brew bundle'."
fi

echo "🎉 Setup complete! Restart terminal to see changes."

