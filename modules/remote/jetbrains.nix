{ pkgs ? import <nixpkgs> { }, ... }:

{
  systemd.user.services.jetbrains-patcher = {
    description = "Automatically fix the JetBrains used by the Remote Dev";
    unitConfig.ConditionPathIsDirectory = "%h/.cache/JetBrains/RemoteDev/dist";
    serviceConfig = {
      Restart = "always";
      ExecStart = pkgs.writeShellScript "patch-jetbrains" ''
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
}
