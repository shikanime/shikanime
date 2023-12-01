{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "sfeir.internal" = {
      identityFile = [ "${config.home.homeDirectory}/.ssh/sfeir_ed25519" ];
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@gitlab.com:**";
      contents.url."git@gitlab.com:**".insteadOf = "git@sfeir.internal:**";
    }
    {
      condition = "hasconfig:remote.*.url:git@gitlab.com:Sfeir/**";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "phetsinorath.w@sfeir.com";
          signingKey = "2EC6BC5847E93460";
        };
        url."git@gitlab.com:**".insteadOf = "git@sfeir.internal:**";
      };
    }
    {
      condition = "hasconfig:remote.*.url:git@gitlab.com:phetsinorath.w/**";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "phetsinorath.w@sfeir.com";
          signingKey = "2EC6BC5847E93460";
        };
        url."git@gitlab.com:**".insteadOf = "git@sfeir.internal:**";
      };
    }
  ];
}
