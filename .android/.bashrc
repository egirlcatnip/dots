#!/usr/bin/env bash
# .bashrc
# @egirlcatnip

# Set XDG directories
export XDG_HOME="${HOME}"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Native prompt
export PS1="\u@\h | bash\n\[\e[34m\]\w\[\e[0m\]\n\[\e[32m\]\$\[\e[0m\] "

initialize_starship() {
  mkdir -p "$XDG_STATE_HOME/starship"
  starship init bash >"$XDG_STATE_HOME/starship/starship.sh"
  source "$XDG_STATE_HOME/starship/starship.sh"
}

initialize_zoxide() {
  mkdir -p "$XDG_STATE_HOME/zoxide"
  zoxide init bash >"$XDG_STATE_HOME/zoxide/zoxide.sh"
  source "$XDG_STATE_HOME/zoxide/zoxide.sh"
}

configure_interactive_shell() {
  [ -n "$PS1" ] && {
    initialize_starship
    initialize_zoxide
  }
}

if [ -n "$PS1" ]; then
  configure_interactive_shell
fi