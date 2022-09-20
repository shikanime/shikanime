{ pkgs, lib, ... }:

with lib;

{
  systemd.user.services.vscode-server-patcher = {
    description = "Automatically fix the VS Code server used by the remote SSH extension";
    script = ''
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
            --set-interpreter "${pkgs.glibc}/lib/ld-linux-x86-64.so.2" \
            --set-rpath "${makeLibraryPath [pkgs.stdenv.cc.cc.lib]}" \
            "$out$filename"
        fi
      done
    '';
  };

  systemd.user.paths.vscode-server-patcher = {
    description = "Monitor VS Code server connection";
    pathConfig.PathExists = "%h/.vscode-server/bin";
    wantedBy = [ "multi-user.target" ];
  };

  systemd.user.services.vscode-server-extensions-patcher = {
    description = "Automatically fix the VS Code server extensions used by the remote SSH extension";
    script = ''
      ${pkgs.inotify-tools}/bin/inotifywait \
        --monitor \
        --recursive \
        --event create \
        --event moved_to \
        --event modify \
        "$HOME/.vscode-server/extensions" \
        | while IFS=:" " read -r out event filename;
      do
        if ${pkgs.file}/bin/file "$out$filename" | grep -q ELF; then
          ${pkgs.patchelf}/bin/patchelf \
            --set-interpreter "${pkgs.glibc}/lib/ld-linux-x86-64.so.2" \
            --set-rpath "${makeLibraryPath [pkgs.stdenv.cc.cc.lib pkgs.zlib pkgs.zlib]}:${pkgs.openjdk}/lib/openjdk/lib" \
            "$out$filename"
        fi
      done
    '';
  };

  systemd.user.paths.vscode-server-extensions-patcher = {
    description = "Monitor VS Code server extensions connection";
    pathConfig.PathExists = "%h/.vscode-server/extensions";
    wantedBy = [ "multi-user.target" ];
  };
}
