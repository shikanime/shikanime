{ pkgs, ... }:

{
  users.users.vscode = {
    isNormalUser = true;
    home = "/home/vscode";
    shell = pkgs.fish;
    extraGroups = [
      "docker"
      "wheel"
    ];
    initialHashedPassword = "";
  };

  home-manager.users.vscode = {
    imports = [
      ../../home/profiles/base.nix
      ../../home/profiles/beam.nix
      ../../home/profiles/cloud.nix
      ../../home/profiles/go.nix
      ../../home/profiles/java.nix
      ../../home/profiles/javascript.nix
      ../../home/profiles/nixtar.nix
      ../../home/profiles/python.nix
      ../../home/profiles/rustup.nix
      ../../home/profiles/starship.nix
      ../../home/profiles/vcs.nix
      ../../home/profiles/workstation.nix
    ];

    home = {
      homeDirectory = "/home/vscode";
      username = "vscode";
    };
  };
}
