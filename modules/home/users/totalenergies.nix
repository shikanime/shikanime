{ config, pkgs, ... }:

{
  programs.git.includes = [
    {
      condition = "gitdir:${config.home.homeDirectory}/TotalEnergies/";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "william.phetsinorath@external.totalenergies.com";
          signingKey = "FDEA7AEA663DC732";
        };
        core.sshCommand = "${pkgs.openssh}/bin/ssh -i ${config.home.homeDirectory}/.ssh/totalenergies_rsa";
      };
    }
  ];
}
