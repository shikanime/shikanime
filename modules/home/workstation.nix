{ lib, pkgs, ... }:

with lib;

{
  home.packages = [
    pkgs.bitwarden-cli
    pkgs.cachix
    pkgs.devenv
    pkgs.glances
    pkgs.qpdf
    pkgs.rclone
    pkgs.wget
    pkgs.zip
  ];

  # FIX: https://github.com/Mic92/sops-nix/issues/890
  launchd.agents.sops-nix = mkIf pkgs.stdenv.isDarwin {
    enable = true;
    config.EnvironmentVariables.PATH = mkForce "/usr/bin:/bin:/usr/sbin:/sbin";
  };

  programs = {
    carapace.enable = true;

    dircolors.enable = true;

    direnv = {
      enable = true;
      mise.enable = true;
      nix-direnv.enable = true;
      config.global.load_dotenv = true;
    };

    gpg.enable = true;

    mise.enable = true;

    nix-index.enable = true;

    nushell = {
      enable = true;
      extraConfig = ''
        $env.config.show_banner = false

        source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/vscode/vscode-completions.nu
      '';
    };

    ssh = {
      enable = true;
      matchBlocks = {
        "catbox.taila659a.ts.net" = {
          user = "shika";
          setEnv.TERM = "xterm-256color";
        };
        "fushi.taila659a.ts.net" = {
          user = "shika";
          setEnv.TERM = "xterm-256color";
        };
        "minish.taila659a.ts.net" = {
          user = "shika";
          setEnv.TERM = "xterm-256color";
        };
        "nishir.taila659a.ts.net" = {
          user = "shika";
          setEnv.TERM = "xterm-256color";
        };
        "thinkcentre-m710t.tailfb4bb2.ts.net" = {
          user = "william-phetsinorath";
          setEnv.TERM = "xterm-256color";
        };
      };
    };

    zoxide.enable = true;
  };

  xdg.enable = true;
}
