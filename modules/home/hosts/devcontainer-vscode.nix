{
  imports = [
    ./devcontainer-base.nix
  ];

  home = {
    homeDirectory = "/home/vscode";
    username = "vscode";
  };
}
