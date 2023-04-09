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
}
