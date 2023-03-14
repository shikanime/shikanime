{ pkgs, ... }:

{
  packages = [
    pkgs.rclone
    pkgs.google-cloud-sdk
    pkgs.terraform
  ];
}
