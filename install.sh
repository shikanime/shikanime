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

if [ "$REMOTE_CONTAINERS" == "true" ]; then
  echo "Remote container detected. Setting up Nix..."
  # Check if user environment variables are set because containers doesn't set
  # them by default and Home Manager needs them to work properly
  export USER=${USER:-$(whoami)}
  # Devcontainer feature for Nix script make the per-user profile owned by root,
  # so we need to change the owner to the current user
  sudo chown -R "$USER" /nix/var/nix/profiles/per-user/"$USER"
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
