{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "ssh.dev.azure.com" = {
      identityFile = [ "${config.home.homeDirectory}/.ssh/galec_rsa" ];
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@ssh.dev.azure.com:v3/lec-coo/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "william.phetsinorath-ext@galec.leclerc";
        signingKey = "4BF8F8945A4E3009";
      };
    }
  ];
}
