{ config, pkgs, ... }:

{
  programs.git.includes = [
    {
      condition = "gitdir:${config.home.homeDirectory}/Galec/";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "wphetsinorath-ext@galec.fr";
          signingKey = "B65D12E239C7DE46";
        };
        core.sshCommand = "${pkgs.openssh}/bin/ssh -i ${config.home.homeDirectory}/.ssh/galec_rsa";
      };
    }
  ];
}
