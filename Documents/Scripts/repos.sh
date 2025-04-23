#!/usr/bin/env bash

# Terra
sudo dnf install -y --nogpgcheck --repofrompath \
  'terra,https://repos.fyralabs.com/terra$releasever' \
  terra-release

# RPMFusion Free
sudo dnf install -y --nogpgcheck --repofrompath \
  'rpmfusion-free,https://download1.rpmfusion.org/free/fedora/releases/$releasever/Everything/$basearch/os' \
  rpmfusion-free-release

# RPMFusion Non-Free
sudo dnf install -y --nogpgcheck --repofrompath \
  'rpmfusion-nonfree,https://download1.rpmfusion.org/nonfree/fedora/releases/$releasever/Everything/$basearch/os' \
  rpmfusion-nonfree-release
