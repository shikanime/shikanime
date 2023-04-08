{ pkgs, ... }:

{
  systemd.user.services.jetbrains-remote-development-patcher = {
    description = "Automatically fix the JetBrains Remote Development used by the Remote Dev";
    script = ''
      ${pkgs.inotify-tools}/bin/inotifywait \
        --monitor \
        --event delete \
        --include ".tar.gz" \
        "$HOME/.cache/JetBrains/RemoteDev/dist" \
        | while IFS=:" " read -r out event filename;
      do
        sed -i 's#/lib64/ld-linux-x86-64.so.2#${pkgs.glibc}/lib/ld-linux-x86-64.so.2#g' \
          "$out''${filename%%.tar.gz}/plugins/remote-dev-server/bin/launcher.sh"
      done
    '';
  };

  systemd.user.paths.jetbrains-remote-development-patcher = {
    description = "Monitor JetBrains Remote Development connection";
    pathConfig.PathExists = "%h/.cache/JetBrains/RemoteDev/dist";
    wantedBy = [ "multi-user.target" ];
  };
}
