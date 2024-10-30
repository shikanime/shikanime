{ config, pkgs, lib, ... }:

with lib;

{
  xdg.enable = true;

  home.sessionPath = [
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.packages = [
    pkgs.cachix
    pkgs.gnupatch
    pkgs.gnumake
    pkgs.gnused
    pkgs.gnugrep
    pkgs.less
    pkgs.zip
    pkgs.unzip
    pkgs.which
    pkgs.bzip2
    pkgs.graphviz
    pkgs.rsync
    pkgs.curl
    pkgs.wget
    pkgs.watch
    pkgs.pprof
  ];

  programs.mise = {
    enable = true;
    globalConfig.settings.experimental = true;
  };

  programs.dircolors.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "sudo"
        "docker"
      ];
    };
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
      $env.config = { show_banner: false }
      use ${pkgs.nu_scripts}/share/nu_scripts/themes/nu-themes/catppuccin-latte.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/curl/curl-completions.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/docker/docker-completions.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/git/git-completions.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/less/less-completions.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/make/make-completions.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/man/man-completions.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/ssh/ssh-completions.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/tar/tar-completions.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/vscode/vscode-completions.nu
      use ${pkgs.nu_scripts}/share/nu_scripts/modules/argx *
      use ${pkgs.nu_scripts}/share/nu_scripts/modules/lg *
      use ${pkgs.nu_scripts}/share/nu_scripts/modules/system *
      use ${pkgs.nu_scripts}/share/nu_scripts/modules/docker *
    '';
  };

  programs.starship.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    mise.enable = true;
    config.global.load_dotenv = true;
  };

  programs.jq.enable = true;

  programs.gpg.enable = true;

  programs.ssh = {
    enable = true;
    package = pkgs.openssh;
    addKeysToAgent = "yes";
  };
}
