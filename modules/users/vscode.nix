{ pkgs, ... }:

{
  services.syncthing = {
    user = "vscode";
    group = "users";
    dataDir = "/home/vscode";
    folders = {
      Default = {
        enable = true;
        id = "default";
        path = "/home/vscode/Sync";
        devices = [
          "Altashar"
          "Ishtar"
          "Olva"
          "Elkia"
          "Elven Gard"
        ];
      };
      Source = {
        enable = true;
        id = "source";
        path = "/home/vscode/Source";
        devices = [
          "Altashar"
          "Ishtar"
          "Olva"
          "Elkia"
          "Elven Gard"
        ];
      };
      Sfeir = {
        enable = true;
        id = "Sfeir";
        path = "/home/vscode/Sfeir";
        devices = [
          "Altashar"
          "Ishtar"
          "Olva"
          "Elkia"
          "Elven Gard"
        ];
      };
    };
  };

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
  home-manager.users.vscode = {
    imports = [
      ../home/users/google.nix
      ../home/users/shikanime.nix
      ../home/users/sfeir.nix
      ../home/profiles/workstation.nix
      ../home/profiles/xdg.nix
      ../home/profiles/vcs.nix
      ../home/profiles/cc.nix
      ../home/profiles/ruby.nix
      ../home/profiles/beam.nix
      ../home/profiles/go.nix
      ../home/profiles/opam.nix
      ../home/profiles/rust.nix
      ../home/profiles/python.nix
      ../home/profiles/web.nix
      ../home/profiles/php.nix
      ../home/profiles/latex.nix
      ../home/profiles/sql.nix
      ../home/profiles/cloud.nix
      ../home/profiles/java.nix
      ../home/profiles/dotnet.nix
    ];
  };
}
