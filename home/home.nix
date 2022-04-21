{ pkgs ? import <nixpkgs> { }, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Session configuration
  home.sessionVariables.EDITOR = "vim";

  # Local programs
  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Core global utilitary packages
  home.packages =
    [ pkgs.daemonize pkgs.openssh pkgs.unzip pkgs.htop pkgs.yq pkgs.zip ];

  home.file.".editorconfig".text = ''
    # top-most EditorConfig file
    root = true

    # Unix-style newlines with a newline ending every file
    [*]
    end_of_line = lf
    insert_final_newline = true

    # Matches multiple files with brace expansion notation
    # Set default charset
    [*.{js,py}]
    charset = utf-8

    # 4 space indentation
    [*.py]
    indent_style = space
    indent_size = 4

    # Tab indentation (no size specified)
    [Makefile]
    indent_style = tab
  '';

  programs.vim.enable = true;

  programs.jq.enable = true;

  programs.dircolors.enable = true;

  programs.bash.enable = true;

  programs.zsh = {
    enable = true;
    autocd = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    enableSyntaxHighlighting = true;
    oh-my-zsh.enable = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  services.syncthing.enable = true;
}
