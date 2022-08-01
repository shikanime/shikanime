{ config, ... }:

{
  # Local programs
  home.sessionPath = [
    "${config.xdg.dataHome}/go/bin"
  ];

  programs.go = {
    enable = true;
    goPath = ".local/share/go";
  };
}
