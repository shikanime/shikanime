{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Enable XDG base directories
  xdg.enable = true;

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Session configuration
  home.sessionVariables.EDITOR = "vim";

  # Core global utilitary packages
  home.packages = [
    pkgs.nixpkgs-fmt
  ];

  programs.vim.enable = true;

  programs.jq.enable = true;

  programs.dircolors.enable = true;

  programs.bash.enable = true;

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "vim-interaction"
      ];
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "elkia.local" = {
        hostname = "elkia.local";
        identityFile = "~/.ssh/elkia";
        user = "devas";
        forwardX11 = true;
        forwardAgent = true;
      };
      "elvengard.local" = {
        hostname = "elvengard.local";
        identityFile = "~/.ssh/elvengard";
        user = "devas";
        forwardX11 = true;
        forwardAgent = true;
      };
    };
  };
}
