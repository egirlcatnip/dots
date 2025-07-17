#!/usr/bin/env fish
# /etc/fish/config.fish
# @egirlcatnip

# Set XDG directories
set XDG_CONFIG_HOME "$HOME/.config"
set XDG_DATA_HOME "$HOME/.local/share"
set XDG_STATE_HOME "$HOME/.local/state"

# Native prompt
set -g fish_prompt_pwd_dir_length 0
function fish_prompt
    echo (whoami)"@"(hostname)" | fish"
    echo (set_color blue)(prompt_pwd)(set_color normal)
    echo -n (set_color green)"\$ "(set_color normal)
end

function initialize_starship
    mkdir -p "$XDG_STATE_HOME/starship"
    starship init fish >"$XDG_STATE_HOME/starship/starship.fish"
    source "$XDG_STATE_HOME/starship/starship.fish"
end

function initialize_zoxide
    mkdir -p "$XDG_STATE_HOME/zoxide"
    zoxide init fish >"$XDG_STATE_HOME/zoxide/zoxide.fish"
    source "$XDG_STATE_HOME/zoxide/zoxide.fish"
end

function configure_interactive_shell
    initialize_starship
    initialize_zoxide

end

function configure_non_interactive_shell
    :;
end

# Variables
set fish_greeting ""

# Check if interactive shell
if status --is-interactive
    configure_interactive_shell
else
    configure_non_interactive_shell
end
