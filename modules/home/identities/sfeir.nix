{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "gitlab.sfeir.internal" = {
      hostname = "gitlab.com";
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
        contents.user = { inherit name email signingKey; };
      }
      {
        condition = "hasconfig:remote.*.url:git@gitlab.com:phetsinorath.w/**";
        contents.user = { inherit name email signingKey; };
      }
    ];

  programs.git.extraConfig.url = {
    "ssh://git@gitlab.sfeir.internal/Sfeir".insteadOf = "ssh://git@gitlab.com/Sfeir";
    "ssh://git@gitlab.sfeir.internal/phetsinorath.w".insteadOf = "ssh://git@gitlab.com/phetsinorath.w";
  };
}
