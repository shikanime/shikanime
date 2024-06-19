{ config, pkgs, ... }:

{
  imports = [
    ../identities/sfeir.nix
    ../identities/shikanime.nix
    ../profiles/base.nix
    ../profiles/editor.nix
    ../profiles/workstation.nix
    ../profiles/xdg.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
    ../profiles/javascript.nix
    ../profiles/python.nix
    ../profiles/native.nix
    ../profiles/beam.nix
    ../profiles/go.nix
  ];

  home.packages = [ pkgs.wslu ];

  nix.package = pkgs.nix;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    defaultCacheTtl = 4 * 60 * 60;
    pinentryPackage = pkgs.pinentry-qt;
  };

  targets.genericLinux.enable = true;

  programs.git.extraConfig.credential.helper =
    "/mnt/c/Users/${config.home.username}/scoop/shims/git-credential-manager.exe";

  # CUDA support
  home.sessionVariables.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";

  # Browser open support
  home.sessionVariables.BROWSER = "${pkgs.wslu}/bin/wslview";
}
