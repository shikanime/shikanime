{
  imports = [
    ../identities/sfeir.nix
    ../profiles/base.nix
    ../profiles/editor.nix
    ../profiles/workstation.nix
    ../profiles/xdg.nix
    ../profiles/vcs.nix
    ../profiles/cloud.nix
    ../profiles/javascript.nix
    ../profiles/java.nix
    ../profiles/python.nix
    ../profiles/native.nix
    ../profiles/beam.nix
  ];

  home.homeDirectory = "/home/vscode";
  home.username = "vscode";
}
