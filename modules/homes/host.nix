{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "elkia.local" = {
        hostname = "elkia.local";
        identityFile = "~/.ssh/elkia";
        user = "devas";
        forwardX11 = true;
        forwardAgent = true;
      };
      "elvengard.local" = {
        hostname = "elvengard.local";
        identityFile = "~/.ssh/elvengard";
        user = "devas";
        forwardX11 = true;
        forwardAgent = true;
      };
    };
  };
}
