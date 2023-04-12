{
  users.users.nixos.openssh.authorizedKeys.keyFiles = [
    (builtins.fetchurl {
      url = "https://github.com/shikanime.keys";
      sha256 = "sha256:0gz0n7rbxlxjn7h6gn6ag1i3d66ziqj39943cka52m827c2q9a5k";
    })
  ];
}
