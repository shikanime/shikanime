{ config, pkgs, ... }:

{
  home.packages = [ pkgs.wslu ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    defaultCacheTtl = 4 * 60 * 60;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  # Re-use Windows credentials
  programs.git.extraConfig.credential.helper =
    "/mnt/c/Users/${config.home.username}/scoop/shims/git-credential-manager.exe";

  # Browser open support
  home.sessionVariables.BROWSER = "${pkgs.wslu}/bin/wslview";
}
