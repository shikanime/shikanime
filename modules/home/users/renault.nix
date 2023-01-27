{ config, pkgs, ... }:

{
  programs.git.includes = [
    {
      condition = "gitdir:${config.home.homeDirectory}/Renault/";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "william.phetsinorath-extern@renault.com";
          signingKey = "AA83063619D0AAEF";
        };
        core.sshCommand = "${pkgs.openssh}/bin/ssh -i ${config.home.homeDirectory}/.ssh/renault_rsa";
      };
    }
  ];
}
