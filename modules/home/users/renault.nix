{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "gitlab.renault.x.shikanime.studio" = {
      identityFile = "${config.home.homeDirectory}/.ssh/renault_rsa";
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@gitlab.renault.x.shikanime.studio:**";
      contents.user = {
        name = "William Phetsinorath";
        email = "william.phetsinorath-extern@renault.com";
        signingKey = "AA83063619D0AAEF";
      };
    }
  ];
}
