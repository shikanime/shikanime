{ config, pkgs, ... }:

{
  imports = [
    ../profiles/base.nix
    ../profiles/beam.nix
    ../profiles/cloud.nix
    ../profiles/go.nix
    ../profiles/java.nix
    ../profiles/javascript.nix
    ../profiles/python.nix
    ../profiles/rustup.nix
    ../profiles/vcs.nix
    ../profiles/workstation.nix
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_SYNC_DIR = "${config.home.homeDirectory}/Sync";
      XDG_SOURCE_DIR = "${config.home.homeDirectory}/Source";
    };
  };

  home.packages = [ pkgs.wslu ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    defaultCacheTtl = 4 * 60 * 60;
    pinentryPackage = pkgs.pinentry-qt;
  };

  programs.git.extraConfig.credential.helper =
    "/mnt/c/Users/${config.home.username}/scoop/shims/git-credential-manager.exe";

  # CUDA support
  home.sessionVariables.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";

  # Browser open support
  home.sessionVariables.BROWSER = "${pkgs.wslu}/bin/wslview";
}
