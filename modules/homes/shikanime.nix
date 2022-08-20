{ pkgs, config, ... }:

{
  programs.mercurial = {
    userName = "Shikanime Deva";
    userEmail = "shikanime.deva@shikanime.studio";
  };

  programs.git = {
    userName = "Shikanime Deva";
    userEmail = "shikanime.deva@shikanime.studio";
    signing = {
      key = "B9443725856FF9EB";
      signByDefault = true;
    };
  };
}
