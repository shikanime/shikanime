{
  users.users.nixos.openssh.authorizedKeys.keyFiles = [
    (builtins.fetchurl {
      url = "https://github.com/shikanime.keys";
      sha256 = "sha256:0lgxy0j5bxy7q52f7yds03spckvb6g1j7q1h3mrm666fjmxz0zw0";
    })
  ];
}
