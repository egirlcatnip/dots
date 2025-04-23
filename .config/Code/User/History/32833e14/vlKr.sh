#!/usr/bin/env bash
# curl -Ssl https://raw.githubusercontent.com/egirlcatnip/dotfiles/main/setup.sh | sh

# egirlcatscript
VERSION="0.8"

set -euo pipefail

INFO_COLOR="\033[0;34m"
OK_COLOR="\033[0;32m"
WARN_COLOR="\033[1;33m"
RESET_COLOR="\033[0m"

log_info() {
  printf "${INFO_COLOR}>>${RESET_COLOR} %s\n" "$1"
}

log_ok() {
  printf "${OK_COLOR}>>${RESET_COLOR} %s\n" "$1"
}

log_warn() {
  printf "${WARN_COLOR}>>${RESET_COLOR} %s\n" "$1"
}

disclaimer() {
  log_info "egirlcatscript $VERSION"
  log_info "This script will install core tools and download dotfiles."

  confirm || (log_warn "Aborted" && return 1)

}

confirm() {
    read -p "Proceed? [y/N]: " response < /dev/tty

    case "$(echo "$response" | tr '[:upper:]' '[:lower:]')" in
      y|yes) return 0;;
      *) return 1;;
    esac

}

install_repos() {
  log_info "Setting up repositories"

  log_info "Enabling Terra repository"
  sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release || log_warn "Failed to enable Terra repository"

  log_info "Enabling RPM Fusion Free repository"
  sudo dnf install --nogpgcheck --repofrompath 'rpmfusion-free,https://repos.rpmfusion.org/free$releasever' rpmfusion-free || log_warn "Failed to enable RPM Fusion Free repository"

  log_info "Enabling RPM Fusion Non-Free repository"
  sudo dnf install --nogpgcheck --repofrompath 'rpmfusion-nonfree,https://repos.rpmfusion.org/nonfree$releasever' rpmfusion-nonfree || log_warn "Failed to enable RPM Fusion Non-Free repository"
}

install_tools() {
  log_info "Installing core tools"
  sudo dnf install -y \
    fish \
    starship \
    fastfetch \
    micro \
    btop \
    topgrade \
    ripgrep \
    fd-find \
    gh \
    tealdeer \
    gdb \
    bat \
    zoxide \
    || log_warn "Some packages failed"

  log_ok "Core tools installed"
}

dotfiles() {
  DOTDIR="$HOME/.dotfiles"
  log_info "Downloading dotfiles to \`$DOTDIR\`"

  if [ -d "$DOTDIR" ]; then
    git -C "$DOTDIR" pull -f || log_warn "Dotfiles update failed"
  else
    git clone https://github.com/egirlcatnip/dotfiles "$DOTDIR" || log_warn "Clone failed"
  fi


  log_info "Applying dotfiles"

  mkdir -p "$HOME/.config/Code" "$HOME/.config/fastfetch" "$HOME/.config/fish" "$HOME/.config/xkb" "$HOME/.config/xonsh" "$HOME/.config/YouTube Music" "$HOME/.config/micro"

  cp -f -r "$DOTDIR/.bashrc" "$HOME/.bashrc"

  cp -f -r "$DOTDIR/.config/Code" "$HOME/.config/Code"
  cp -f -r "$DOTDIR/.config/fastfetch" "$HOME/.config/fastfetch"
  cp -f -r "$DOTDIR/.config/fish" "$HOME/.config/fish"
  cp -f -r "$DOTDIR/.config/xkb" "$HOME/.config/xkb"
  cp -f -r "$DOTDIR/.config/xonsh" "$HOME/.config/xonsh"
  cp -f -r "$DOTDIR/.config/YouTube Music" "$HOME/.config/YouTube Music"

  cp -f -r "$DOTDIR/.config/starship.toml" "$HOME/.config/starship.toml"
  cp -f -r "$DOTDIR/.config/micro" "$HOME/.config/micro"

  log_ok "Dotfiles applied"
}

set_fish() {
  if [ "$SHELL" != "/usr/bin/fish" ]; then
    log_info "Changing default shell to fish"
    sudo chsh -s /usr/bin/fish "$USER"
    sudo chsh -s /usr/bin/fish root
    log_ok "Default shell is now fish"
  else
    log_ok "Fish is already default shell"
  fi
}

update() {
  log_info "Update system?"

  if confirm; then
    topgrade -y
  else
    log_warn "Skipping system update"
  fi
}

apply_dconf() {
  log_info "Apply dconf?"

  if confirm; then {
    # Set window manager keybindings
    dconf write /org/gnome/desktop/wm/keybindings/close "['<Super>q']"
    dconf write /org/gnome/desktop/wm/keybindings/maximize "@as []"
    dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-left "@as []"
    dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-right "@as []"
    dconf write /org/gnome/desktop/wm/keybindings/show-desktop "['<Super>d']"
    dconf write /org/gnome/desktop/wm/keybindings/switch-applications "@as []"
    dconf write /org/gnome/desktop/wm/keybindings/switch-applications-backward "@as []"
    dconf write /org/gnome/desktop/wm/keybindings/switch-windows "['<Alt>Tab']"
    dconf write /org/gnome/desktop/wm/keybindings/switch-windows-backward "['<Shift><Alt>Tab']"
    dconf write /org/gnome/desktop/wm/keybindings/toggle-fullscreen "['<Control><Super>f']"
    dconf write /org/gnome/desktop/wm/keybindings/toggle-maximized "['<Super>f']"
    dconf write /org/gnome/desktop/wm/keybindings/unmaximize "@as []"

    # Set Battery Health Charging settings
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/amend-power-indicator false
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/charging-mode "'ful'"
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/device-type 1
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/icon-style-type 0
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/indicator-position-max 4
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/polkit-status "'installed'"
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/show-battery-panel2 false
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/show-notifications false
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/show-preferences false
    dconf write /org/gnome/shell/extensions/Battery-Health-Charging/show-quickmenu-subtitle true

    # Set autohide battery extension
    dconf write /org/gnome/shell/extensions/autohide-battery/hide-always true

    # Set aztaskbar extension settings
    dconf write /org/gnome/shell/extensions/aztaskbar/clock-font-size "(false, 12)"
    dconf write /org/gnome/shell/extensions/aztaskbar/clock-position-in-panel "'CENTER'"
    dconf write /org/gnome/shell/extensions/aztaskbar/clock-position-offset 1
    dconf write /org/gnome/shell/extensions/aztaskbar/dance-urgent true
    dconf write /org/gnome/shell/extensions/aztaskbar/favorites true
    dconf write /org/gnome/shell/extensions/aztaskbar/hide-dash true
    dconf write /org/gnome/shell/extensions/aztaskbar/indicator-location "'TOP'"
    dconf write /org/gnome/shell/extensions/aztaskbar/isolate-monitors false
    dconf write /org/gnome/shell/extensions/aztaskbar/isolate-workspaces false
    dconf write /org/gnome/shell/extensions/aztaskbar/main-panel-height "(true, 40)"
    dconf write /org/gnome/shell/extensions/aztaskbar/override-panel-clock-format "(true, '%A  |  %d. %m. %Y  |  %H:%M:%S ')"
    dconf write /org/gnome/shell/extensions/aztaskbar/position-in-panel "'LEFT'"
    dconf write /org/gnome/shell/extensions/aztaskbar/position-offset 1
    dconf write /org/gnome/shell/extensions/aztaskbar/prefs-visible-page "''"
    dconf write /org/gnome/shell/extensions/aztaskbar/show-apps-button "(true, 0)"
    dconf write /org/gnome/shell/extensions/aztaskbar/show-panel-activities-button true
    dconf write /org/gnome/shell/extensions/aztaskbar/show-weather-by-clock "'OFF'"
    dconf write /org/gnome/shell/extensions/aztaskbar/tool-tips false
    dconf write /org/gnome/shell/extensions/aztaskbar/update-notifier-project-version 28
    dconf write /org/gnome/shell/extensions/aztaskbar/window-previews true
  }
  else
    log_warn "Skipping dconf"
  fi
}

extensions() {
  log_info "Install gnome-extensions?"

  if confirm; then
    cp -r $DOTDIR/gnome-extensions-backup ~/.local/share/gnome-shell/extensions
  else
    log_warn "Skipping gnome-extensions"
  fi
}


finalize() {
  update

  echo
  echo

  fastfetch
}

main() {
  disclaimer || return 1

  sudo -v

  dotfiles
  install_repos
  install_tools
  extensions
  apply_dconf
  set_fish
  finalize
}

main
