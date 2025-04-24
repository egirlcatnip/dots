#!/usr/bin/env bash

dconf write /org/gnome/desktop/wm/keybindings/close "['<Super>q']"
dconf write /org/gnome/desktop/wm/keybindings/toggle-maximized "['<Super>f']"
dconf write /org/gnome/desktop/wm/keybindings/toggle-fullscreen "['<Control><Super>f']"

dconf write /org/gnome/desktop/wm/keybindings/show-desktop "['<Super>d']"

dconf write /org/gnome/desktop/wm/keybindings/switch-windows "['<Alt>Tab']"
dconf write /org/gnome/desktop/wm/keybindings/switch-windows-backward "['<Shift><Alt>Tab']"

dconf write /org/gnome/desktop/wm/preferences/button-layout "'appmenu:minimize,maximize,close'"

dconf write /org/gnome/desktop/interface/gtk-theme "'adw-gtk3'"

pip install gnome-extensions-cli

gnome-extemsion-cli install "accent-directories@taiwbi.com"
gnome-extemsion-cli install "auto-accent-colour@Wartybix"
gnome-extemsion-cli install "autohide-battery-percentage@rukins.github.io"
gnome-extemsion-cli install "autohide-battery@sitnik.ru"
gnome-extemsion-cli install "autohide-volume@unboiled.info"
gnome-extemsion-cli install "aztaskbar@aztaskbar.gitlab.com"
gnome-extemsion-cli install "Battery-Health-Charging@maniacx.github.com"
gnome-extemsion-cli install "batterytime@typeof.p"
gnome-extemsion-cli install "Bluetooth-Battery-Meter@maniacx.github.com"
gnome-extemsion-cli install "blur-my-shell@aunetx"
gnome-extemsion-cli install "caffeine@patapon.info"
gnome-extemsion-cli install "foresight@pesader.de"
gnome-extemsion-cli install "gravatar@dsheeler.ne"
gnome-extemsion-cli install "just-perfection-desktop@just-perfection"
gnome-extemsion-cli install "light-style@gnome-shell-extensions.gcampax.github.com"
gnome-extemsion-cli install "nightthemeswitcher@romainvigier.fr"
gnome-extemsion-cli install "pip-on-top@rafostar.github.com"
gnome-extemsion-cli install "quick-settings-avatar@d-g"
gnome-extemsion-cli install "quick-settings-tweaks@qwreey"
gnome-extemsion-cli install "quicksettings-audio-devices-renamer@marcinjahn.co"
gnome-extemsion-cli install "steal-my-focus-window@steal-my-focus-windo"
gnome-extemsion-cli install "tailscale@joaophi.github.com"
gnome-extemsion-cli install "tandem-raise@tomdryer.co"
gnome-extemsion-cli install "tilingshell@ferrarodomenico.com"
gnome-extemsion-cli install "touchpad@gpawr"
gnome-extemsion-cli install "vscode-search-provider@mrmarble.github.com"
gnome-extemsion-cli install "weeks-start-on-monday@extensions.gnome-shell.fifi.org"
gnome-extemsion-cli install "wifiqrcode@glerro.pm.me"
