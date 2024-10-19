{
  imports = [
    ../profiles/base.nix
    ../profiles/xdg.nix
  ];

  targets.genericLinux.enable = true;
}
