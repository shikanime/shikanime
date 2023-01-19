{ pkgs, ... }:

{
  # TODO: I'm exclusively stealing the Syncthing service
  services.syncthing = {
    user = "devas";
    group = "users";
    dataDir = "/home/devas";
    folders = {
      "Default" = {
        enable = true;
        id = "default";
        path = "/home/devas/Sync";
        devices = [
          "Altashar"
          "Ishtar"
          "Olva"
          "Elkia"
          "Elven Gard"
        ];
      };
      "Source" = {
        enable = true;
        id = "source";
        path = "/home/devas/Source";
        devices = [
          "Altashar"
          "Ishtar"
          "Olva"
          "Elkia"
          "Elven Gard"
        ];
      };
      "Sfeir" = {
        enable = true;
        id = "Sfeir";
        path = "/home/devas/Sfeir";
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
  users.users.devas = {
    isNormalUser = true;
    home = "/home/devas";
    extraGroups = [
      "docker"
      "wheel"
      "syncthing"
    ];
    shell = pkgs.zsh;
    hashedPassword = "$6$YS5jCyZU2Z6i05wm$jFsx9fnINawEk2Vd5uZBdR71sOBHHgANUEBsp93fG3scp2uui3kYhzXh9c4eC4ZdHKq48//IWE00JwZ.ez.lg.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7pi5OYqzuMkTymIbJUJteIU3dz+OgduiF5O9cA+B7u devas@ishtar"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFChPMDHee+8F8tuchk8nLqdzVj1SOfLFv70NH95K6Yf williamphetsinorath@altashar"
    ];
    packages = [
      pkgs.inotify-tools
    ];
  };

  # Configure user home
  home-manager.users.devas = {
    imports = [
      ../home/users/totalenergies.nix
      ../home/users/google.nix
      ../home/users/shikanime.nix
      ../home/users/sfeir.nix
      ../home/users/paprec.nix
      ../home/users/galec.nix
      ../home/users/lvmh.nix
      ../home/users/birdz.nix
      ../home/users/amadeus.nix
      ../home/profiles/base.nix
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
