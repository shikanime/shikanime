{ config, pkgs, ... }:

{
  programs.git.includes = [
    {
      condition = "gitdir:${config.home.homeDirectory}/Celine/";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "william.phetsinorath-ext@celine.fr";
          signingKey = "688247A82F19BF0D";
        };
        core.sshCommand = "${pkgs.openssh}/bin/ssh -i ${config.home.homeDirectory}/.ssh/lvmh_rsa";
      };
    }
    {
      condition = "gitdir:${config.home.homeDirectory}/Moynat/";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "wphetsinorath_ext@moynat.com";
          signingKey = "E144E994EA47B1A8";
        };
        core.sshCommand = "${pkgs.openssh}/bin/ssh -i ${config.home.homeDirectory}/.ssh/lvmh_rsa";
      };
    }
  ];
}
