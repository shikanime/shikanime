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
}
