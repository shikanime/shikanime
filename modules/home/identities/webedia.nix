{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "gitlab.com" = {
      identityFile = [ "${config.home.homeDirectory}/.ssh/webedia_ed25519" ];
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@gitlab.com:webediagroup/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "william.phetsinorath@ext.webedia-group.com";
        signingKey = "0EE52A8E3A05142A";
      };
    }
    {
      condition = "hasconfig:remote.*.url:git@gitlab.com:william.phetsinorath/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "william.phetsinorath@ext.webedia-group.com";
        signingKey = "0EE52A8E3A05142A";
      };
    }
  ];
}
