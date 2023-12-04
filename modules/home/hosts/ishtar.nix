{ lib, pkgs, ... }:

with lib;

let
  initExtra = mkAfter ''
    if [[ -z "$SSH_AUTH_SOCK" ]]; then
      #start ssh-agent
      eval "$(ssh-agent -s)"
    fi
  '';
in
{
  imports = [
    ../identities/sfeir.nix
    ../profiles/base.nix
    ../profiles/editor.nix
    ../profiles/workstation.nix
    ../profiles/xdg.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
    ../profiles/javascript.nix
    ../profiles/java.nix
    ../profiles/python.nix
    ../profiles/native.nix
    ../profiles/beam.nix
    ../profiles/go.nix
  ];

  home = {
    homeDirectory = "/home/shika";
    username = "shika";
    packages = [ pkgs.wslu ];
  };

  nix.package = pkgs.nix;

  services.gpg-agent = {
    enable = true;
    enableExtraSocket = true;
    defaultCacheTtl = 4 * 60 * 60;
    pinentryFlavor = "tty";
  };

  targets.genericLinux.enable = true;

  programs.git.extraConfig.credential.helper =
    "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";

  # CUDA support
  home.sessionVariables.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";

  programs.zsh = { inherit initExtra; };
  programs.bash = { inherit initExtra; };
}
