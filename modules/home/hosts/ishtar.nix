{ pkgs, ... }:

{
  home.homeDirectory = "/home/devas";
  home.username = "devas";

  nix.package = pkgs.nix;

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
