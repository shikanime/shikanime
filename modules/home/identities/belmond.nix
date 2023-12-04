{ config, ... }:

{
  programs.ssh.matchBlocks = {
    "github.com" = {
      identityFile = [ "${config.home.homeDirectory}/.ssh/belmond_ed25519" ];
    };
  };

  programs.git.includes = [
    {
      condition = "hasconfig:remote.*.url:git@gitlab.com/belmond-dev/**";
      contents.user = {
        name = "William Phetsinorath";
        email = "ext-william-PHETSINORATH@belmond.com";
        signingKey = "4987E64C1F27AC13";
      };
    }
  ];
}
