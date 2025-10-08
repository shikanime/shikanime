{
  languages.opentofu.enable = true;
  git-hooks.hooks.tflint.enable = true;
  packages = [
    pkgs.scaleway-cli
  ];
}
