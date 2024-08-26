{ lib, pkgs, ... }:

with lib;

let
  initExtra = ''
    # Fix GPG TTY
    export GPG_TTY=$(tty)

    if command -v brew >/dev/null; then
      eval "$(brew shellenv)"
    fi

    if [ -d "/opt/homebrew/opt/openjdk/bin" ]; then
      export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
    fi
  '';
in
{
  imports = [
    ../profiles/base.nix
    ../profiles/editor.nix
    ../profiles/workstation.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
    ../profiles/javascript.nix
    ../profiles/python.nix
    ../profiles/native.nix
    ../profiles/beam.nix
    ../profiles/go.nix
  ];

  nix.package = pkgs.nix;

  programs.zsh = { inherit initExtra; };
  programs.bash = { inherit initExtra; };
}
