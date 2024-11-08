{
  imports = [
    ../profiles/base.nix
    ../profiles/beam.nix
    ../profiles/cloud.nix
    ../profiles/go.nix
    ../profiles/java.nix
    ../profiles/javascript.nix
    ../profiles/kaltashar.nix
    ../profiles/python.nix
    ../profiles/rustup.nix
    ../profiles/vcs.nix
    ../profiles/workstation.nix
  ];

  home = {
    homeDirectory = "/Users/shikanimedeva";
    username = "shikanimedeva";
  };
}
