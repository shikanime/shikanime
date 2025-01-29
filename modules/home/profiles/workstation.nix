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
          "0=#51576d"
          "1=#e78284"
          "2=#a6d189"
          "3=#e5c890"
          "4=#8caaee"
          "5=#f4b8e4"
          "6=#81c8be"
          "7=#b5bfe2"
          "8=#626880"
          "9=#e78284"
          "10=#a6d189"
          "11=#e5c890"
          "12=#8caaee"
          "13=#f4b8e4"
          "14=#81c8be"
          "15=#a5adce"
        ];
        background = "303446";
        foreground = "c6d0f5";
        cursor-color = "f2d5cf";
        selection-background = "44495d";
        selection-foreground = "c6d0f5";
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
