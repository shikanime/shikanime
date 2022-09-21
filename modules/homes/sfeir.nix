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
      condition = "gitdir:${config.home.homeDirectory}/Source/Repos/sfeir/";
      contents = {
        user = {
          name = "William Phetsinorath";
          email = "phetsinorath.w@sfeir.com";
          signingKey = "9A31DF925449E15A";
        };
        commit.gpgSign = true;
      };
    }
  ];
}
