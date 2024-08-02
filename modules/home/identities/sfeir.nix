let
  userName = "William Phetsinorath";
  userEmail = "phetsinorath.w@sfeir.com";
  signingKey = "2EC6BC5847E93460";
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
    git.push-branch-prefix = "trunks/phetsinorath.w/";
  };
}
