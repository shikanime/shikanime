{
  imports = [
    ../../home/identities/sfeir.nix
    ../../home/identities/galec.nix
    ../../home/identities/tagheuer.nix
    ../../home/identities/totalenergies.nix
    ../../home/identities/webedia.nix
    ../../home/profiles/base.nix
    ../../home/profiles/editor.nix
    ../../home/profiles/workstation.nix
    ../../home/profiles/xdg.nix
    ../../home/profiles/vcs.nix
    ../../home/profiles/cloud.nix
    ../../home/profiles/javascript.nix
    ../../home/profiles/java.nix
    ../../home/profiles/python.nix
    ../../home/profiles/native.nix
    ../../home/profiles/beam.nix
  ];

  home.homeDirectory = "/home/vscode";
  home.username = "vscode";
}
