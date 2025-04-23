#!/usr/bin/env xonsh
# @egirlcatnip

# Set XDG directories
$XDG_CONFIG_HOME = "$HOME/.config"
$XDG_DATA_HOME = "$HOME/.local/share"
$XDG_STATE_HOME = "$HOME/.local/state"

# Install package if not present
def install_if_missing(package, install_cmd):
    if not $(command -v {package}):
        print(f"{package} not found. Installing...")
        $(eval {install_cmd})
    else:
        print(f"{package} already installed.")

# Append path if not present
def append_to_path(path):
    if path not in $PATH:
        $PATH.append(path)

# Add path if directory exists
def if_exists_add_path(dir):
    if os.path.isdir(dir):
        append_to_path(dir)

# Install required tools
def install_dependencies():
    install_if_missing("starship", "sudo dnf install starship")
    install_if_missing("zoxide", "sudo dnf install zoxide")

# Set editor based on terminal type
def set_editor():
    if $TERM == "linux":
        # TTY
        $EDITOR = "micro"
    else:
        # Graphical
        $EDITOR = "codium"

# Initialize Starship prompt
def initialize_starship():
    os.makedirs(f"{$XDG_STATE_HOME}/starship", exist_ok=True)
    !starship init xonsh > "{$XDG_STATE_HOME}/starship/starship.xsh"
    source("{$XDG_STATE_HOME}/starship/starship.xsh")

# Initialize Zoxide
def initialize_zoxide():
    os.makedirs(f"{$XDG_STATE_HOME}/zoxide", exist_ok=True)
    !zoxide init xonsh > "{$XDG_STATE_HOME}/zoxide/zoxide.xsh"
    source("{$XDG_STATE_HOME}/zoxide/zoxide.xsh")

# Configure interactive shell
def configure_interactive_shell():
    if $PS1:
        install_dependencies()
        initialize_starship()
        initialize_zoxide()

# Non-interactive shell (no config needed)
def configure_non_interactive_shell():
    pass

# Add paths if directories exist
if_exists_add_path("$HOME/.cargo/bin")
if_exists_add_path("$HOME/.deno/bin")

# Aliases
aliases['gcc'] = "gcc -Wall -Wpedantic -Wextra -Wno-deprecated-declarations -x c"
aliases['g++'] = "g++ -Wall -Wpedantic -Wextra -Wno-deprecated-declarations -x c++"

# Check if interactive shell
if $PS1:
    configure_interactive_shell()
    set_editor()
else:
    configure_non_interactive_shell()
