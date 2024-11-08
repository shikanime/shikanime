
{
  imports = [
    ../profiles/base.nix
    ../profiles/wsl.nix
    ../users/shika.nix
  ];

  networking.hostName = "ishtar";
}
