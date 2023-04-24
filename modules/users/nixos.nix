{
  users.users.nixos.openssh.authorizedKeys.keyFiles = [
    (builtins.fetchurl {
      url = "https://github.com/shikanime.keys";
      sha256 = "sha256:1055smm1afc9zhbs2svbwap7a276gyjirry5sc3g9w6bl82wbdky";
    })
  ];
}
