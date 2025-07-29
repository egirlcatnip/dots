#!/usr/bin/env nu
# ~/.config/nushell/config.nu
# @egirlcatnipst

# Set XDG directories
$env.xdg_home = "~" | path expand
$env.xdg_config_home = $env.xdg_home | path join ".config"
$env.xdg_data_home = $env.xdg_home | path join ".local/share"
$env.xdg_state_home = $env.xdg_home | path join ".local/state"

if ($env.TERMUX_VERSION? | is-not-empty) {
  $env.USER = "emi"
} else {
  $env.USER = whoami
}

$env.HOSTNAME = (hostname)

# Native prompt
$env.PROMPT_COMMAND = { ||
  let user = whoami
  let hostname = hostname
  let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
  }

  let first_line = $"(ansi default)($user)@($hostname) | nush"
  let second_line = $"(ansi light_blue)($dir)"
  let third_line = $"(ansi light_green)$"

  return $"($first_line)\n($second_line)\n($third_line) "
}

$env.PROMPT_INDICATOR = ""

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
$env.EDITOR = "code"

if $nu.is-interactive {
  initialize_starship
  initialize_zoxide
}
