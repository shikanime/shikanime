{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "gitlab.sfeir.x.shikanime.studio" = {
      identityFile = "${config.home.homeDirectory}/.ssh/sfeir_ed25519";
    };
    "github.sfeir.x.shikanime.studio" = {
      identityFile = "${config.home.homeDirectory}/.ssh/sfeir_ed25519";
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@gitlab.sfeir.x.shikanime.studio:**";
      contents.user = {
        name = "William Phetsinorath";
        email = "phetsinorath.w@sfeir.com";
        signingKey = "2EC6BC5847E93460";
      };
    }
    {
      condition = "hasconfig:remote.*.url:git@github.sfeir.x.shikanime.studio:**";
      contents.user = {
        name = "William Phetsinorath";
        email = "phetsinorath.w@sfeir.com";
        signingKey = "2EC6BC5847E93460";
      };
    }
  ];
}
