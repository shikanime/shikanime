{
  targets.genericLinux.enable = true;

  programs.git.extraConfig.credential.helper =
    "/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager-core.exe";

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    enableExtraSocket = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
