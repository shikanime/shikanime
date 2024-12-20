{ pkgs, ... }:

{
  users.users.vscode = {
    isNormalUser = true;
    home = "/home/vscode";
    shell = pkgs.zsh;
    extraGroups = [
      "docker"
      "wheel"
    ];
  };

  home-manager.users.vscode = {
    imports = [
      ../../home/profiles/base.nix
      ../../home/profiles/beam.nix
      ../../home/profiles/cloud.nix
      ../../home/profiles/go.nix
      ../../home/profiles/ishtar.nix
      ../../home/profiles/java.nix
      ../../home/profiles/javascript.nix
      ../../home/profiles/python.nix
      ../../home/profiles/rustup.nix
      ../../home/profiles/vcs.nix
      ../../home/profiles/workstation.nix
      ../../home/identities/shikanime.nix
    ];

    home = {
      homeDirectory = "/home/vscode";
      username = "vscode";
    };
  };
}
