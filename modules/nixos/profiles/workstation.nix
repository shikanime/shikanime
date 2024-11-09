{ pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
