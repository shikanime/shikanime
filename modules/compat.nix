{ pkgs ? import <nixpkgs> { }, lib, ... }:

{
  systemd.user.services.vscode-server-patcher = {
    description = "Automatically fix the VS Code server used by the remote SSH extension";
    serviceConfig = {
      Restart = "always";
      ExecStart = pkgs.writeShellScript "patch-vscode-server" ''
        ${pkgs.inotify-tools}/bin/inotifywait \
          --monitor \
          --recursive \
          --event create \
          --event moved_to \
          "$HOME/.vscode-server/bin" \
          | while IFS=:" " read -r out event filename;
        do
          if ${pkgs.file}/bin/file "$out$filename" | grep -q ELF; then
            ${pkgs.patchelf}/bin/patchelf \
              --set-interpreter "${pkgs.glibc.out}/lib/ld-linux-x86-64.so.2" \
              --set-rpath "${lib.makeLibraryPath [pkgs.stdenv.cc.cc.lib]}" \
              "$out$filename"
          fi
        done
      '';
    };
    wantedBy = [ "default.target" ];
  };

  systemd.user.services.jetbrains-patcher = {
    description = "Automatically fix the JetBrains used by the Remote Dev";
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
