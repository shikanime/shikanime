{ pkgs ? import <nixpkgs> { }, lib, ... }:

with lib;

{
  systemd.user.services.vscode-server-patcher = {
    description = "Automatically fix the VS Code server used by the remote SSH extension";
    unitConfig.Type = "simple";
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
              --set-rpath "${makeLibraryPath [pkgs.stdenv.cc.cc.lib]}" \
              "$out$filename"
          fi
        done
      '';
    };
    wantedBy = [ "default.target" ];
  };

  systemd.user.paths.vscode-server-patcher = {
    description = "Monitor VS Code server connection";
    pathConfig = {
      PathExists = "%h/.vscode-server/bin";
      Unit = "vscode-server-patcher.service";
    };
    wantedBy = [ "default.target" ];
  };

  systemd.user.services.vscode-server-extensions-patcher = {
    description = "Automatically fix the VS Code server extensions used by the remote SSH extension";
    unitConfig.Type = "simple";
    serviceConfig = {
      Restart = "always";
      ExecStart = pkgs.writeShellScript "patch-vscode-server" ''
        ${pkgs.inotify-tools}/bin/inotifywait \
          --monitor \
          --recursive \
          --event create \
          --event moved_to \
          "$HOME/.vscode-server/extensions" \
          | while IFS=:" " read -r out event filename;
        do
          if ${pkgs.file}/bin/file "$out$filename" | grep -q ELF; then
            ${pkgs.patchelf}/bin/patchelf \
              --set-interpreter "${pkgs.glibc.out}/lib/ld-linux-x86-64.so.2" \
              --set-rpath "${makeLibraryPath [pkgs.stdenv.cc.cc.lib]}" \
              "$out$filename"
          fi
        done
      '';
    };
    wantedBy = [ "default.target" ];
  };

  systemd.user.paths.vscode-server-extensions-patcher = {
    description = "Monitor VS Code server extensions connection";
    pathConfig = {
      PathExists = "%h/.vscode-server/extensions";
      Unit = "vscode-server-extensions-patcher.service";
    };
    wantedBy = [ "default.target" ];
  };
}
