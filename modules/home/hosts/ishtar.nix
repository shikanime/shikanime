{
  home.homeDirectory = "/home/devas";
  home.username = "devas";

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  targets.genericLinux.enable = true;

  programs.git.extraConfig.credential.helper =
    "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe";

  # CUDA support
  home.sessionVariables.LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
}
