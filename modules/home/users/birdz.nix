{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "gitlab.birdz.x.shikanime.studio" = {
      identityFile = "${config.home.homeDirectory}/.ssh/birdz_ed25519";
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@gitlab.birdz.x.shikanime.studio:**";
      contents.user = {
        name = "William Phetsinorath";
        email = "phetsinorath.w@sfeir.com";
        signingKey = "AA83063619D0AAEF";
      };
    }
  ];
}
