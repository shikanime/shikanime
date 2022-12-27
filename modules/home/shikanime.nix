{ config, ... }:

{
  programs.mercurial = {
    userName = "William Phetsinorath";
    userEmail = "william.phetsinorath@shikanime.studio";
  };

  programs.git = {
    userName = "William Phetsinorath";
    userEmail = "william.phetsinorath@shikanime.studio";
    includes = [
      {
        condition = "gitdir:${config.home.homeDirectory}/Source/";
        contents = {
          user = {
            name = "William Phetsinorath";
            email = "william.phetsinorath@shikanime.studio";
            signingKey = "025CF1599FA70256";
          };
        };
      }
    ];
  };
}
