let
  userName = "William Phetsinorath";
  userEmail = "william.phetsinorath@shikanime.studio";
  signingKey = "EB584D3ACB58F471";
in
{
  programs.ssh.matchBlocks = {
    "ishtar-ubuntu.tail9fed3.ts.net" = {
      extraOptions.User = "shika";
    };
    "nishir.tail9fed3.ts.net" = {
      extraOptions.User = "shika";
    };
  };

  programs.mercurial = {
    inherit userName userEmail;
  };

  programs.git = {
    inherit userName userEmail;
    signing.key = signingKey;
  };

  programs.sapling = {
    inherit userName userEmail;
    extraConfig.gpg.key = signingKey;
  };
}
