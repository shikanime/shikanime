{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = [ "${config.home.homeDirectory}/.ssh/totalenergies_ed25519" ];
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@github.com:TotalEnergiesCode/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "william.phetsinorath@external.totalenergies.com";
        signingKey = "FDEA7AEA663DC732";
      };
    }
    {
      condition = "hasconfig:remote.*.url:git@github.com:AL1083054_totalen/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "william.phetsinorath@external.totalenergies.com";
        signingKey = "FDEA7AEA663DC732";
      };
    }
  ];
}
