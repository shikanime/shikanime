{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = [ "${config.home.homeDirectory}/.ssh/paprec_ed25519" ];
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@github.com:Paprec/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "phetsinorath.w@sfeir.com";
        signingKey = "AA83063619D0AAEF";
      };
    }
  ];
}
