{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = [ "${config.home.homeDirectory}/.ssh/tagheuer_ed25519" ];
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@github.com:w-and-j-central/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "william.phetsinorath-ext@tagheuer.com";
        signingKey = "14E3D69C6CDF8593";
      };
    }
  ];
}
