{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/go.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/nodejs.nix
    ../../../../modules/home/python.nix
    ../../../../modules/home/rustup.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/unix.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
  ];

  programs.bash.enable = true;
}
