{ config, pkgs, ... }:

{
  programs.git.includes = [
    {
      condition = "gitdir:${config.home.homeDirectory}/Birdz/";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "phetsinorath.w@sfeir.com";
          signingKey = "AA83063619D0AAEF";
        };
        core.sshCommand = "${pkgs.openssh}/bin/ssh -i ${config.home.homeDirectory}/.ssh/birdz_ed25519";
      };
    }
  ];
}
