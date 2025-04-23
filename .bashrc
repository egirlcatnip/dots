#!/usr/bin/env bash
# @egirlcatnip

# Set XDG directories
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Install package if not present
install_if_missing() {
  local package="$1"
  local install_cmd="$2"
  if ! command -v "$package" &>/dev/null; then
    echo "$package not found. Installing..."
    eval "$install_cmd"
  fi
}

# Append path if not present
append_to_path() {
  local path="$1"
  [[ ":$PATH:" != *":$path:"* ]] && export PATH="$PATH:$path"
}

# Add path if directory exists
if_exists_add_path() {
  local dir="$1"
  [ -d "$dir" ] && append_to_path "$dir"
}

# Install required tools
install_dependencies() {
  install_if_missing "starship" "sudo dnf install starship"
  install_if_missing "zoxide" "sudo dnf install zoxide"
}

# Set editor based on terminal
set_editor() {
  if [[ "$TERM" == "linux" ]]; then
    # TTY
    export EDITOR="micro"
  else
    # Graphical
    export EDITOR="codium"
  fi
}

# Initialize Starship prompt
initialize_starship() {
  mkdir -p "$XDG_STATE_HOME/starship"
  starship init bash >"$XDG_STATE_HOME/starship/starship.sh"
  source "$XDG_STATE_HOME/starship/starship.sh"
}

# Initialize Zoxide
initialize_zoxide() {
  mkdir -p "$XDG_STATE_HOME/zoxide"
  zoxide init bash >"$XDG_STATE_HOME/zoxide/zoxide.sh"
  source "$XDG_STATE_HOME/zoxide/zoxide.sh"
}

# Configure interactive shell
configure_interactive_shell() {
  [ -n "$PS1" ] && {
    install_dependencies
    initialize_starship
    initialize_zoxide
  }
}

# Non-interactive shell (no config needed)
configure_non_interactive_shell() { :; }

# Add paths if directories exist
if_exists_add_path "$HOME/.cargo/bin"
if_exists_add_path "$HOME/.deno/bin"
if_exists_add_path "$HOME/.local/bin"

# Aliases
alias gcc="gcc -Wall -Wpedantic -Wextra -Wno-deprecated-declarations -x c"
alias g++="g++ -Wall -Wpedantic -Wextra -Wno-deprecated-declarations -x c++"

# Check if interactive shell
if [ -n "$PS1" ]; then
  configure_interactive_shell
  set_editor
else
  configure_non_interactive_shell
fi
