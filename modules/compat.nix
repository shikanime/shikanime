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
          --format "%w%f" \
          "$HOME/.vscode-server/bin" \
          | while IFS=: read -r filename;
        do
          if ${pkgs.file}/bin/file $filename | grep -q ELF; then
            ${pkgs.patchelf}/bin/patchelf \
              --set-interpreter "${pkgs.glibc.out}/lib/ld-linux-x86-64.so.2" \
              --set-rpath "${lib.makeLibraryPath [pkgs.stdenv.cc.cc.lib]}" \
              $filename
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
          --format "%w" \
          "$HOME/.cache/JetBrains/RemoteDev/dist" \
          | while IFS=: read -r out;
        do
          find $out/*/plugins/remote-dev-server/bin \
            -mindepth 1 \
            -maxdepth 1 \
            -name launcher.sh \
            -type f \
            | while IFS=: read -r file;
          do
            sed -i 's#/lib64/ld-linux-x86-64.so.2#${pkgs.glibc.out}/lib/ld-linux-x86-64.so.2#g' \
              "$file"
          done
        done
      '';
    };
    wantedBy = [ "default.target" ];
  };
}
