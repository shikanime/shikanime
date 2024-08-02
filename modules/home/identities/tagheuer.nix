let
  userName = "William Phetsinorath";
  userEmail = "william.phetsinorath-ext@tagheuer.com";
  signingKey = "14E3D69C6CDF8593";
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
    git.push-branch-prefix = "trunks/william.phetsinorath-ext/";
  };
}
