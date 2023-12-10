{ lib, pkgs, ... }:

with lib;

let
  initExtra = mkAfter ''
    if command -v brew >/dev/null; then
      eval "$(brew shellenv)"
    fi
  '';
in
{
  imports = [
../../home/identities/sfeir.nix
../../home/profiles/base.nix
../../home/profiles/editor.nix
../../home/profiles/workstation.nix
../../home/profiles/vcs.nix
../../home/profiles/cloud.nix
../../home/profiles/javascript.nix
../../home/profiles/java.nix
../../home/profiles/python.nix
../../home/profiles/native.nix
../../home/profiles/beam.nix
../../home/profiles/go.nix
  ];

  home.homeDirectory = "/Users/williamphetsinorath";
  home.username = "williamphetsinorath";

  nix.package = pkgs.nix;

  programs.zsh = { inherit initExtra; };
  programs.bash = { inherit initExtra; };
}
