let
  user = "phetsinorath.w";
  organization = "Sfeir";
  userName = "William Phetsinorath";
  userEmail = "${userName}@sfeir.com";
in
{
  programs.git.includes =
    let signingKey = "2EC6BC5847E93460"; in
    [
      {
        condition = "hasconfig:remote.*.url:gitlab.com/${organization}/**";
        contents.user = {
          inherit signingKey;
          name = userName;
          email = userEmail;
        };
      }
      {
        condition = "hasconfig:remote.*.url:gitlab.com/${user}/**";
        contents.user = { inherit name email signingKey; };
      }
    ];

  programs.git.extraConfig.credential =
    {
      "https://gitlab.com/${organization}".username = user;
      "https://gitlab.com/${user}".username = user;
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
  };
}
