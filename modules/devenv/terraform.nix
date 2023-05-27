{ pkgs, ... }:

{
  pre-commit.hooks.terraform-format.enable = true;
  packages = [ pkgs.terraform ];
}
