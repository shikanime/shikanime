{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "gitlab.com" = {
      identityFile = [ "${config.home.homeDirectory}/.ssh/sfeir_ed25519" ];
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@gitlab.com:Sfeir/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "phetsinorath.w@sfeir.com";
        signingKey = "2EC6BC5847E93460";
      };
    }
    {
      condition = "hasconfig:remote.*.url:git@gitlab.com:phetsinorath.w/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "phetsinorath.w@sfeir.com";
        signingKey = "2EC6BC5847E93460";
      };
    }
  ];
}
