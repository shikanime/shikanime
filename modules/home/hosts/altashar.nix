{ pkgs, lib, ... }:

with lib;

{
  imports = [
    ../identities/totalenergies.nix
    ../identities/sfeir.nix
    ../identities/paprec.nix
    ../identities/galec.nix
    ../identities/birdz.nix
    ../identities/renault.nix
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
    ../profiles/javascript.nix
    ../profiles/python.nix
    ../profiles/rust.nix
  ];

  home.homeDirectory = "/Users/williamphetsinorath";
  home.username = "williamphetsinorath";

  nix.package = pkgs.nix;

  programs.zsh.initExtra = mkAfter ''
    if command -v brew >/dev/null; then
      eval "$(brew shellenv)"
    fi
  '';
}
