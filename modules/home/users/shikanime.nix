{ config, ... }:

{
  programs.git = {
    includes = [
      {
        condition = "gitdir:${config.home.homeDirectory}/Source/";
        contents = {
          user = {
            signingKey = "025CF1599FA70256";
          };
        };
      }
    ];
  };
}
