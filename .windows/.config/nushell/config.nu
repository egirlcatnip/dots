#!/usr/bin/env nu
# ~/.config/nushell/config.nu
# @egirlcatnip

# Set XDG directories
$env.xdg_home = "~" | path expand
$env.xdg_config_home = $env.xdg_home | path join ".config"
$env.xdg_data_home = $env.xdg_home | path join ".local/share"
$env.xdg_state_home = $env.xdg_home | path join ".local/state"

# Native prompt
$env.PROMPT_COMMAND = { ||
    let user = $env.USER
    let hostname = hostname

    let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
            null => $env.PWD
            '' => '~'
            $relative_pwd => ([~ $relative_pwd] | path join)
    }

    return $"($user)@($hostname) | nush\n(ansi light_blue)($dir)\n(ansi light_green)$(ansi reset) "
}
$env.PROMPT_COMMAND_RIGHT = { || }

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
$env.EDITOR = "micro"

if $nu.is-interactive {
    initialize_starship
    # initialize_zoxide
}

if ($env.TERMUX_VERSION | is-not-empty) {
        $env.USER = "emi"
} else {
        $env.USER = whoami
}