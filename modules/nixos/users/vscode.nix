{ pkgs, ... }:

{
  # Create user accounts
  users.users.vscode = {
    isNormalUser = true;
    home = "/home/vscode";
    extraGroups = [ "docker" "wheel" "syncthing" ];
    shell = pkgs.zsh;
    initialHashedPassword = "";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPW5kSIFStkESjXOavgJg75Wfxnsml7+ZT0grMnYNzwC"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAB8e13bjswnhfuYYpztBESPf/gkbkdGE46kC++tNOCX"
    ];
  };

  # Configure user home
  home-manager.users.vscode.imports = [
    ../../home/hosts/vscode.nix
  ];
}
