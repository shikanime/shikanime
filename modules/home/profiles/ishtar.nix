{ config, ... }:

{
  # Re-use Windows credentials
  programs.git.extraConfig.credential.helper =
    "/mnt/c/Users/${config.home.username}/scoop/shims/git-credential-manager.exe";
}
