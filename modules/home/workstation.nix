{ pkgs, ... }:

{
  home.packages = [
    pkgs.bzip2
    pkgs.cachix
    pkgs.curl
    pkgs.gitnr
    pkgs.glances
    pkgs.gnugrep
    pkgs.gnumake
    pkgs.gnupatch
    pkgs.gnused
    pkgs.graphviz
    pkgs.less
    pkgs.qpdf
    pkgs.rclone
    pkgs.rsync
    pkgs.unzip
    pkgs.watch
    pkgs.wget
    pkgs.which
    pkgs.zip
  ];

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

    jq.enable = true;

    mise.enable = true;

    nix-index.enable = true;

    nushell = {
      enable = true;
      extraConfig = ''
        $env.config.show_banner = false

        use ${pkgs.nu_scripts}/share/nu_scripts/modules/argx *
        use ${pkgs.nu_scripts}/share/nu_scripts/modules/lg *
        use ${pkgs.nu_scripts}/share/nu_scripts/modules/system *
        use ${pkgs.nu_scripts}/share/nu_scripts/modules/docker *

        source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/curl/curl-completions.nu
        source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/less/less-completions.nu
        source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/make/make-completions.nu
        source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/man/man-completions.nu
        source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/tar/tar-completions.nu
        source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/vscode/vscode-completions.nu
      '';
    };

    ssh = {
      enable = true;
      matchBlocks = {
        fushi = {
          hostname = "fushi.taila659a.ts.net";
          user = "shika";
          setEnv.TERM = "xterm-256color";
        };
        minish = {
          hostname = "minish.taila659a.ts.net";
          user = "shika";
          setEnv.TERM = "xterm-256color";
        };
        nishir = {
          hostname = "nishir.taila659a.ts.net";
          user = "shika";
          setEnv.TERM = "xterm-256color";
        };
        localhost = {
          hostname = "localhost";
          user = "shika";
          port = 2222;
          setEnv.TERM = "xterm-256color";
        };
      };
    };

    zoxide.enable = true;
  };

  xdg.enable = true;
}
