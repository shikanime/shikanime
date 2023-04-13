{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "github.demeter.x.shikanime.studio" = {
      identityFile = "${config.home.homeDirectory}/.ssh/totalenergies_ed25519";
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@github.demeter.x.shikanime.studio:**";
      contents.user = {
        name = "William Phetsinorath";
        email = "william.phetsinorath@external.totalenergies.com";
        signingKey = "FDEA7AEA663DC732";
      };
    }
  ];
}
