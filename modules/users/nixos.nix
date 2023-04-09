{
  users.users.nixos.openssh.authorizedKeys.keyFiles = [
    (builtins.fetchurl {
      url = "https://github.com/shikanime.keys";
      sha256 = "sha256:0y83aiibdbh49zw9qrhy8m418556lrpdbpdh477d4qwdial650wh";
    })
  ];
}
