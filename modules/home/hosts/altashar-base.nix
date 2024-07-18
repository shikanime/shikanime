{ lib, pkgs, ... }:

with lib;

let
  initExtra = ''
    if command -v brew >/dev/null; then
      eval "$(brew shellenv)"
    fi
  '';
in
{
  imports = [
    ../identities/shikanime.nix
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
