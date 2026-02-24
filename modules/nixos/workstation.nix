{ pkgs, ... }:

{
  programs = {
    chromium.enable = true;

    firefox = {
      enable = true;
      package = pkgs.firefox-devedition;
    };

    gnupg.agent = {
      enable = true;
      enableExtraSocket = true;
      pinentryPackage = pkgs.pinentry-all;
      settings.default-cache-ttl = 60 * 60;
    };
  };
}
