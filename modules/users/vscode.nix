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
          "ElvenGard"
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
          "ElvenGard"
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
          "ElvenGard"
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
    openssh.authorizedKeys.keyFiles = [
      (builtins.fetchurl {
        url = "https://github.com/shikanime.keys";
        sha256 = "sha256:0lgxy0j5bxy7q52f7yds03spckvb6g1j7q1h3mrm666fjmxz0zw0";
      })
    ];
  };

  # Configure user home
  home-manager.users.vscode = {
    imports = [
      ../home/users/totalenergies.nix
      ../home/users/sfeir.nix
      ../home/users/paprec.nix
      ../home/users/galec.nix
      ../home/users/birdz.nix
      ../home/profiles/base.nix
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
      ../home/profiles/latex.nix
      ../home/profiles/sql.nix
      ../home/profiles/cloud.nix
      ../home/profiles/java.nix
    ];
  };
}
