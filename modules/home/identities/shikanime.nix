let
  userName = "William Phetsinorath";
  userEmail = "william.phetsinorath@shikanime.studio";
  signingKey = "EF31089F1F165C80";
in
{
  programs.mercurial = {
    inherit userName userEmail;
  };

  programs.git = {
    inherit userName userEmail;
    signing = {
      signByDefault = true;
      key = signingKey;
    };
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
    git.push-branch-prefix = "trunks/shikanime/";
  };
}
