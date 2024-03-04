{ pkgs, ... }:

{
  # Create user accounts
  users.users.vscode = {
    isNormalUser = true;
    home = "/home/vscode";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    initialHashedPassword = "";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICGJ1GT3xsOpvFmXWOjNkCBjeRNn7tWiFV4bTXoYe3+V"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAB8e13bjswnhfuYYpztBESPf/gkbkdGE46kC++tNOCX"
    ];
  };

  # Configure user home
  home-manager.users.vscode.imports = [
    ../../home/identities/sfeir.nix
    ../../home/identities/shikanime.nix
    ../../home/profiles/base.nix
    ../../home/profiles/editor.nix
    ../../home/profiles/workstation.nix
    ../../home/profiles/xdg.nix
    ../../home/profiles/vcs.nix
    ../../home/profiles/cloud.nix
    ../../home/profiles/javascript.nix
    ../../home/profiles/java.nix
    ../../home/profiles/python.nix
    ../../home/profiles/native.nix
    ../../home/profiles/beam.nix
  ];
}
