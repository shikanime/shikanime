{ pkgs, ... }:

{
  imports = [
    ../identities/totalenergies.nix
    ../identities/sfeir.nix
    ../identities/paprec.nix
    ../identities/galec.nix
    ../identities/birdz.nix
    ../identities/renault.nix
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../profiles/xdg.nix
    ../profiles/vcs.nix
    ../profiles/cc.nix
    ../profiles/ruby.nix
    ../profiles/beam.nix
    ../profiles/go.nix
    ../profiles/opam.nix
    ../profiles/rust.nix
    ../profiles/python.nix
    ../profiles/web.nix
    ../profiles/latex.nix
    ../profiles/sql.nix
    ../profiles/cloud.nix
    ../profiles/java.nix
  ];

  home.homeDirectory = "/home/shika";
  home.username = "shika";

  nix.package = pkgs.nix;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  targets.genericLinux.enable = true;

  programs.git.extraConfig.credential.helper =
    "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";

  # CUDA support
  home.sessionVariables.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
}
