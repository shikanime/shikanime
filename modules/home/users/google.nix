{
  programs.ssh.matchBlocks = {
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
