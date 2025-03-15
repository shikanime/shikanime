{
  imports = [
    ../profiles/base.nix
    ../profiles/beam.nix
    ../profiles/cloud.nix
    ../profiles/devcontainer.nix
    ../profiles/starship.nix
    ../profiles/go.nix
    ../profiles/helix.nix
    ../profiles/java.nix
    ../profiles/javascript.nix
    ../profiles/python.nix
    ../profiles/rustup.nix
    ../profiles/unix.nix
    ../profiles/vcs.nix
    ../profiles/workstation.nix
  ];

  home = {
    homeDirectory = "/home/vscode";
    username = "vscode";
  };
}
