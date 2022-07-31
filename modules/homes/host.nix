{ pkgs, ... }:

{
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "elkia.local" = {
        hostname = "elkia.local";
        identityFile = "~/.ssh/elkia_ed25519";
        user = "devas";
        forwardX11 = true;
        forwardAgent = true;
      };
      "elvengard.local" = {
        hostname = "elvengard.local";
        identityFile = "~/.ssh/elvengard_ed25519";
        user = "devas";
        forwardX11 = true;
        forwardAgent = true;
      };
    };
  };
}
