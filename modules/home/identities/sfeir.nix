{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "github.sfeir.internal" = {
      identityFile = [ "${config.home.homeDirectory}/.ssh/sfeir_ed25519" ];
    };
  };

  programs.git.includes =
    let

      name = "William Phetsinorath";
      email = "phetsinorath.w@sfeir.com";
      signingKey = "2EC6BC5847E93460";
    in
    [
      {
        condition = "hasconfig:remote.*.url:git@gitlab.com:Sfeir/**";
        contents = {
          user = { inherit name email signingKey; };
          url."git@gitlab.com:**".insteadOf = "git@github.sfeir.internal:**";
        };
      }
      {
        condition = "hasconfig:remote.*.url:git@gitlab.com:phetsinorath.w/**";
        contents = {
          user = { inherit name email signingKey; };
          url."git@gitlab.com:**".insteadOf = "git@github.sfeir.internal:**";
        };
      }
    ];
}
