{ pkgs ? import <nixpkgs> { }, ... }:

{
  systemd.user.services.jetbrains-remote-development-patcher = {
    description = "Automatically fix the JetBrains Remote Development used by the Remote Dev";
    serviceConfig = {
      Restart = "always";
      ExecStart = pkgs.writeShellScript "patch-jetbrains-remote-development" ''
        ${pkgs.inotify-tools}/bin/inotifywait \
          --monitor \
          --event delete \
          --include ".tar.gz" \
          "$HOME/.cache/JetBrains/RemoteDev/dist" \
          | while IFS=:" " read -r out event filename;
        do
          sed -i 's#/lib64/ld-linux-x86-64.so.2#${pkgs.glibc.out}/lib/ld-linux-x86-64.so.2#g' \
            "$out''${filename%%.tar.gz}/plugins/remote-dev-server/bin/launcher.sh"
        done
      '';
    };
    wantedBy = [ "default.target" ];
  };

  systemd.user.paths.jetbrains-remote-development-patcher = {
    description = "Monitor JetBrains Remote Development connection";
    pathConfig = {
      PathExists = "%h/.cache/JetBrains/RemoteDev/dist";
      Unit = "jetbrains-remote-development-patcher.service";
    };
    wantedBy = [ "default.target" ];
  };
}
