{ pkgs ? import <nixpkgs> { }, ... }:

{
  home.packages = [
    pkgs.inotify-tools
    pkgs.nerdctl
  ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}
