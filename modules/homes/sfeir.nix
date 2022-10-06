{ pkgs, config, ... }:

{
  programs.ssh = {
    matchBlocks = {
      "sfeir.gitlab.com" = {
        hostname = "gitlab.com";
        identityFile = "~/.ssh/sfeir_ed25519";
      };
      "sfeir.bitbucket.org" = {
        hostname = "bitbucket.org";
        identityFile = "~/.ssh/sfeir_ed25519";
      };
    };
    extraConfig = ''
      AddKeysToAgent yes
    '';
  };

  # TODO: extract to user base isolation
  programs.git.includes = [
    {
      condition = "gitdir:${config.home.homeDirectory}/Sfeir/";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "phetsinorath.w@sfeir.com";
          signingKey = "AA83063619D0AAEF";
        };
      };
    }
  ];
}
