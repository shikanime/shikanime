let
  userName = "William Phetsinorath";
  userEmail = "william.phetsinorath.part@servier.com";
  signingKey = "14165D0F68AF549C";
in
{
  programs.mercurial = {
    inherit userName userEmail;
  };

  programs.git.signing = {
    signByDefault = true;
    key = signingKey;
  };

  programs.sapling = {
    inherit userName userEmail;
    extraConfig.gpg.key = signingKey;
  };

  programs.jujutsu.settings = {
    user = {
      name = userName;
      email = userEmail;
    };
    signing = {
      sign-all = true;
      backend = "gpg";
      key = userEmail;
    };
    git.push-branch-prefix = "trunks/william.phetsinorath.part/";
  };
}
