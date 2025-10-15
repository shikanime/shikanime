{ lib, pkgs, ... }:

with lib;

{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/devcontainer.nix
    ../../../../modules/home/go.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/javascript.nix
    ../../../../modules/home/python.nix
    ../../../../modules/home/rustup.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/unix.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  home = {
    packages = [ pkgs.iputils ];
    sessionVariables.USER = "vscode";
  };

  nix.package = pkgs.nix;

  programs.bash.enable = true;

  targets.genericLinux.enable = true;
}
