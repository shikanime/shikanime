{ pkgs, ... }:

{
  pre-commit.hooks.terraform-format.enable = true;
  packages = [
    pkgs.google-cloud-sdk
    pkgs.terraform
    pkgs.gh
  ];
}
