# SET alias for quick access

alias md="mkdir -p"


# Tell Starship exactly where your custom config file lives
export STARSHIP_CONFIG="$HOME/.config/starship/config.toml"

# Initialize starship prompt
eval "$(starship init zsh)"

