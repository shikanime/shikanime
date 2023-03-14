{ pkgs, ... }:

{
  pre-commit.hooks.terraform-format.enable = true;
  packages = [
    pkgs.rclone
    pkgs.google-cloud-sdk
    pkgs.terraform
  ];
}
