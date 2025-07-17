#!/usr/bin/env xonsh
# /etc/xonsh/config.xsh
# @egirlcatnip

# Set XDG directories
$XDG_CONFIG_HOME = "$HOME/.config"
$XDG_DATA_HOME = "$HOME/.local/share"
$XDG_STATE_HOME = "$HOME/.local/state"

def initialize_starship():
  os.makedirs(f"{$XDG_STATE_HOME}/starship", exist_ok=True)
  !starship init xonsh > "{$XDG_STATE_HOME}/starship/starship.xsh"
  source("{$XDG_STATE_HOME}/starship/starship.xsh")

def initialize_zoxide():
  os.makedirs(f"{$XDG_STATE_HOME}/zoxide", exist_ok=True)
  !zoxide init xonsh > "{$XDG_STATE_HOME}/zoxide/zoxide.xsh"
  source("{$XDG_STATE_HOME}/zoxide/zoxide.xsh")

def configure_interactive_shell():
  if $PS1:
    initialize_starship()
    initialize_zoxide()

def configure_non_interactive_shell():
  pass

# Check if interactive shell
if $PS1:
  configure_interactive_shell()
else:
  configure_non_interactive_shell()
