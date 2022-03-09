{ pkgs ? import <nixpkgs> { }, ... }:

{
  home.packages = [ pkgs.inotify-tools ];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
  };
}
