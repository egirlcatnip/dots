#!/usr/bin/env nu
# ~/.config/nushell/config.nu
# @egirlcatnip

# Set XDG directories
$env.xdg_home = "~" | path expand
$env.xdg_config_home = $env.xdg_home | path join ".config"
$env.xdg_data_home = $env.xdg_home | path join ".local/share"
$env.xdg_state_home = $env.xdg_home | path join ".local/state"

# Native prompt
def create_right_prompt [] {
    let user = whoami
    let hostname = hostname
    let cwd = $env.PWD | path basename

    return "{user}@{hostname} | nush\n{cwd}"
}

def create_left_prompt [] {
    return
}

def initialize_starship [] {
    mkdir ($nu.data-dir | path join "vendor/autoload")
    starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}

def initialize_zoxide [] {
    mkdir ($nu.data-dir | path join "vendor/autoload")
    zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
}

# Variables
$env.config.show_banner = false


if $nu.is-interactive {
    initialize_starship
    initialize_zoxide
}
