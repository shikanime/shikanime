#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

# Check if Nix is installed
if ! command -v nix >/dev/null; then
  echo "Nix is not installed. Installing..."
  # Install Nix with experimental flake config
  sh <(curl -L https://nixos.org/nix/install) --yes --daemon
  # Add Nix to PATH
  # shellcheck source=/dev/null
  source /etc/profile.d/nix.sh
fi

echo "Nix is installed."

# Container run without USER env variable set so we need to set it manually
# in oder to make home-manager work properly
export USER=${USER:-$(whoami)}

# Create per-user profile as it is not created by default
if [[ ! -d /nix/var/nix/profiles/per-user/"$USER" ]]; then
  echo "Creating per-user profile..."
  sudo mkdir -p /nix/var/nix/profiles/per-user/"$USER"
fi

# As the per-user profile is created by root, we need to fix its permissions
# so that the user can access itgit
if [[ -d /nix/var/nix/profiles/per-user/"$USER" ]]; then
  echo "Fix per-user profiles permissions..."
  sudo chown "$USER" /nix/var/nix/profiles/per-user/"$USER"
fi

echo "Nix is set up."

# Install Home
if ! command -v home-manager >/dev/null; then
  echo "Home Manager is not installed. Installing using nixpkgs..."
  nix run nixpkgs#home-manager -- switch \
    --flake github:shikanime/shikanime \
    -b backup-before-nix
else
  echo "Home Manager is installed. Installing using Home Manager..."
  home-manager switch \
    --flake github:shikanime/shikanime \
    -b backup-before-nix
fi

echo "Home installed."
