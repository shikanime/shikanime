{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "github.paprec.x.shikanime.studio" = {
      identityFile = "${config.home.homeDirectory}/.ssh/paprec_ed25519";
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@github.paprec.x.shikanime.studio:**";
      contents.user = {
        name = "William Phetsinorath";
        email = "phetsinorath.w@sfeir.com";
        signingKey = "AA83063619D0AAEF";
      };
    }
  ];
}
