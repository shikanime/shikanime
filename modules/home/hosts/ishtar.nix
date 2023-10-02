{ lib, pkgs, ... }:

with lib;

let
  initExtra = mkAfter ''
    export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
  '';
in
{
  imports = [
    ../identities/sfeir.nix
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../profiles/xdg.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
    ../profiles/javascript.nix
    ../profiles/python.nix
    ../profiles/rust.nix
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

  # Enable Graphical Applications
  programs.zsh = { inherit initExtra; };
  programs.bash = { inherit initExtra; };
}
