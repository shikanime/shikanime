{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    defaultCacheTtl = 4 * 60 * 60;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
