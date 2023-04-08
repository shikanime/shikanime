{ pkgs, ... }:

{
  users.users.automata = {
    isNormalUser = true;
    home = "/home/automata";
    extraGroups = [ "wheel" ];
    hashedPassword = "$y$j9T$BIsUa3mkdYQy8QC6iVkCm/$IbQAa8e/fsGZp1tgc1SWd89fzgYYXSPDeZg92nfNVq8";
  };
}
