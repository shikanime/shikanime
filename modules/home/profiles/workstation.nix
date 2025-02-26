{
  config,
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.bzip2
    pkgs.cachix
    pkgs.curl
    pkgs.gitnr
    pkgs.gnugrep
    pkgs.gnumake
    pkgs.gnupatch
    pkgs.gnused
    pkgs.graphviz
    pkgs.less
    pkgs.pprof
    pkgs.rsync
    pkgs.unzip
    pkgs.watch
    pkgs.wget
    pkgs.which
    pkgs.zip
  ];

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  programs.carapace.enable = true;

  programs.dircolors.enable = true;

  programs.direnv = {
    enable = true;
    mise.enable = true;
    nix-direnv.enable = true;
    config.global.load_dotenv = true;
  };

  programs.ghostty = {
    enable = true;
    package = pkgs.nil;
    themes = {
      catppuccin-latte = {
        palette = [
          "0=#5c5f77"
          "1=#d20f39"
          "2=#40a02b"
          "3=#df8e1d"
          "4=#1e66f5"
          "5=#ea76cb"
          "6=#179299"
          "7=#acb0be"
          "8=#6c6f85"
          "9=#d20f39"
          "10=#40a02b"
          "11=#df8e1d"
          "12=#1e66f5"
          "13=#ea76cb"
          "14=#179299"
          "15=#bcc0cc"
        ];
        background = "eff1f5";
        foreground = "4c4f69";
        cursor-color = "dc8a78";
        selection-background = "d8dae1";
        selection-foreground = "4c4f69";
      };
    };
    settings.theme = "catppuccin-latte";
  };

  programs.gpg.enable = true;

  programs.jq.enable = true;

  programs.mise = {
    enable = true;
    globalConfig.settings.experimental = true;
  };

  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.vim-colemak
    ];
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config = { show_banner: false }

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

  programs.ssh = {
    addKeysToAgent = "yes";
    enable = true;
  };

  programs.starship.enable = true;

  programs.zoxide.enable = true;

  programs.zsh = {
    autosuggestion.enable = true;
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
        "docker"
      ];
    };
    syntaxHighlighting.enable = true;
  };

  xdg.enable = true;
}
