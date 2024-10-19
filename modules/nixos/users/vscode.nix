{ pkgs, ... }:

{
  # Create user accounts
  users.users.vscode = {
    isNormalUser = true;
    home = "/home/vscode";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    initialHashedPassword = "";
  };

  # Configure user home
  home-manager.users.vscode.imports = [
    ../../home/identities/shikanime.nix
    ../../home/profiles/base.nix
    ../../home/profiles/editor.nix
    ../../home/profiles/workstation.nix
    ../../home/profiles/xdg.nix
    ../../home/profiles/vcs.nix
    ../../home/profiles/cloud.nix
    ../../home/profiles/javascript.nix
    ../../home/profiles/python.nix
    ../../home/profiles/native.nix
    ../../home/profiles/beam.nix
  ];
}
