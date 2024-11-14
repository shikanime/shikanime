{
  imports = [
    ../profiles/base.nix
    ../profiles/workstation.nix
    ../users/shika.nix
  ];

  networking.hostName = "kaltashar";
}
