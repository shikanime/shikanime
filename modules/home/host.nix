{
  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  programs.ssh.matchBlocks = {
    "elkia.local" = {
      hostname = "elkia.local";
      identityFile = "~/.ssh/elkia_ed25519";
      user = "devas";
      forwardX11 = true;
      forwardX11Trusted = true;
      forwardAgent = true;
    };
    "elvengard.local" = {
      hostname = "elvengard.local";
      identityFile = "~/.ssh/elvengard_ed25519";
      user = "devas";
      forwardX11 = true;
      forwardX11Trusted = true;
      forwardAgent = true;
    };
    "cloudworkstations.dev" = {
      hostname = "localhost";
      port = 2222;
      user = "user";
      forwardX11 = true;
      forwardX11Trusted = true;
      forwardAgent = true;
    };
  };
}
