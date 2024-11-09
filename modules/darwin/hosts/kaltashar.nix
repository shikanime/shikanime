{
  imports = [
    ../profiles/base.nix
    ../users/shika.nix
  ];

  nix.linux-builder.enable = true;

  homebrew.enable = true;
}
