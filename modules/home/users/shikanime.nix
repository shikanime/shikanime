{ config, ... }:

{
  programs.git = {
    includes = [
      {
        condition = "gitdir:${config.home.homeDirectory}/Source/";
        contents = {
          user = {
            signingKey = "025CF1599FA70256";
          };
        };
      }
    ];
  };

  programs.ssh.matchBlocks = {
    "elkia.local" = {
      hostname = "elkia.local";
      identityFile = "${config.home.homeDirectory}/.ssh/elkia_ed25519";
      user = "devas";
      forwardX11 = true;
      forwardX11Trusted = true;
      forwardAgent = true;
    };
    "elvengard.local" = {
      hostname = "elvengard.local";
      identityFile = "${config.home.homeDirectory}/.ssh/elvengard_ed25519";
      user = "devas";
      forwardX11 = true;
      forwardX11Trusted = true;
      forwardAgent = true;
    };
  };
}
