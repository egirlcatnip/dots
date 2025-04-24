# @egirlcatnip

# Set XDG directories
set XDG_CONFIG_HOME "$HOME/.config"
set XDG_DATA_HOME "$HOME/.local/share"
set XDG_STATE_HOME "$HOME/.local/state"

# Install package if not present
function install_if_missing
    set package $argv[1]
    set install_cmd $argv[2]

    if not type -q $package
        echo "$package not found. Installing..."
        eval $install_cmd
    end
end

# Append path if not present
function append_to_path
    set path $argv[1]
    if not contains -- $path $PATH
        set -gx PATH $PATH $path
    end
end

# Add path if directory exists
function if_exists_add_path
    set dir $argv[1]
    if test -d $dir
        append_to_path $dir
    end
end

# Install required tools
function install_dependencies
    install_if_missing starship "sudo dnf install starship"
    install_if_missing zoxide "sudo dnf install zoxide"
end

# Set editor based on terminal
function set_editor
    if test "$TERM" = linux
        # TTY
        set -gx EDITOR micro
    else
        # Graphical
        set -gx EDITOR codium
    end
end

# Initialize Starship prompt
function initialize_starship
    mkdir -p "$XDG_STATE_HOME/starship"
    starship init fish >"$XDG_STATE_HOME/starship/starship.fish"
    source "$XDG_STATE_HOME/starship/starship.fish"
end

# Initialize Zoxide
function initialize_zoxide
    mkdir -p "$XDG_STATE_HOME/zoxide"
    zoxide init fish >"$XDG_STATE_HOME/zoxide/zoxide.fish"
    source "$XDG_STATE_HOME/zoxide/zoxide.fish"
end

# Configure interactive shell
function configure_interactive_shell
    install_dependencies
    initialize_starship
    initialize_zoxide

end

# Non-interactive shell (no config needed)
function configure_non_interactive_shell
    :
end

# Add paths if directories exist
if_exists_add_path "$HOME/.cargo/bin"
if_exists_add_path "$HOME/.deno/bin"
if_exists_add_path "$HOME/.local/bin"

# Aliases
alias gcc="gcc -Wall -Wpedantic -Wextra -Wno-deprecated-declarations -x c"
alias g++="g++ -Wall -Wpedantic -Wextra -Wno-deprecated-declarations -x c++"

# Variables
set fish_greeting

# Check if interactive shell
if status --is-interactive
    configure_interactive_shell
    set_editor
else
    configure_non_interactive_shell
end
