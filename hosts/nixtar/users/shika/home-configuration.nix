{ config, ... }:

{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/beam.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/go.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/java.nix
    ../../../../modules/home/javascript.nix
    ../../../../modules/home/python.nix
    ../../../../modules/home/rustup.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/unix.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  # Re-use Windows credentials
  programs.git.extraConfig.credential.helper =
    "/mnt/c/Users/${config.home.username}/scoop/shims/git-credential-manager.exe";
}
