{ pkgs, config, ... }:

{
  # Local programs
  home.sessionPath = [
    "${config.xdg.dataHome}/coursier/bin"
  ];

  # Core global utilitary packages
  home.packages = [
    pkgs.coursier
  ];
}
