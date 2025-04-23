#!/usr/bin/env bash

curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up
sudo tailscale set --operator="$USER"
