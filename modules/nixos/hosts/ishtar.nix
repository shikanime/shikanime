{
  imports = [
    ../profiles/base.nix
    ../profiles/wsl.nix
    ../users/shika.nix
  ];

  wsl.defaultUser = "shika";

  networking.hostName = "ishtar";
}
