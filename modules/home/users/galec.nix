{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "devops.galec.x.shikanime.studio" = {
      identityFile = "${config.home.homeDirectory}/.ssh/galec_rsa";
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@devops.galec.x.shikanime.studio:**";
      contents.user = {
        name = "William Phetsinorath";
        email = "wphetsinorath-ext@galec.fr";
        signingKey = "B65D12E239C7DE46";
      };
    }
  ];
}
