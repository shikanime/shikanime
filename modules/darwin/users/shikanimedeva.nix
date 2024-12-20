{ pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.shikanimedeva = {
    home = "/Users/shikanimedeva";
    shell = pkgs.zsh;
  };

  home-manager.users.shikanimedeva = {
    imports = [
      ../../home/profiles/base.nix
      ../../home/profiles/beam.nix
      ../../home/profiles/cloud.nix
      ../../home/profiles/go.nix
      ../../home/profiles/java.nix
      ../../home/profiles/javascript.nix
      ../../home/profiles/python.nix
      ../../home/profiles/rustup.nix
      ../../home/profiles/vcs.nix
      ../../home/profiles/workstation.nix
      ../../home/identities/shikanime.nix
    ];

    home = {
      homeDirectory = "/Users/shikanimedeva";
      username = "shikanimedeva";
    };
  };
}
