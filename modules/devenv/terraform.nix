{ pkgs, ... }:

{
  pre-commit.hooks.terraform-format.enable = true;
  packages = [ pkgs.terraform pkgs.google-cloud-sdk ];
}
