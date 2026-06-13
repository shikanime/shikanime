# Host "Ishtar" — NixOS Dual-Boot Workstation Implementation Plan

> **For Hermes:** Use subagent-driven-development skill to implement this plan task-by-task.

**Goal:** Add a new NixOS host "Ishtar" to the shikanime flake — a dual-boot (NixOS + Windows) workstation on a Razer Blade 16 laptop.

**Architecture:** Follows the existing host pattern: `hosts/ishtar/configuration.nix` + `hosts/ishtar/users/shika/home-configuration.nix`, registered in `modules/flake/nixos.nix`. Uses `nixos-hardware` common modules for laptop/NVIDIA/Intel, OpenRazer for Razer peripherals, systemd-boot with a Windows UEFI entry for dual-boot, and sops-nix for secrets. No disko (dual-boot means Windows partitions must be preserved — manual partitioning at install time).

**Tech Stack:** NixOS unstable, Nix flakes + flake-parts, home-manager, sops-nix, nixos-hardware, systemd-boot, NVIDIA proprietary drivers, OpenRazer, Tailscale.

---

## Hardware Notes & Discrepancy

⚠️ **There is no "Razer Blade 16 (2019)".** The Blade 16 line launched in 2024. The user may mean:
- **Razer Blade 16 (Early 2024):** Intel Core i9-14900HX / i9-13950HX, NVIDIA RTX 4080–4090, 16" QHD+ OLED 240Hz, DDR5-5600
- **Razer Blade 16 (2025):** AMD Ryzen AI 9 HX 370, NVIDIA RTX 5070–5090, 16" QHD+ OLED 240Hz, DDR5-8000
- **Razer Blade 15 (2019):** Intel Core i7-9750H / i9-9880H, RTX 2060–2080, 15.6" — this exists but is not a "Blade 16"

**This plan targets the Blade 16 (2024, Intel variant)** as the most likely match. If the user has the 2025 AMD variant, swap `common-cpu-intel` → `common-cpu-amd` in Task 3. If it's actually a Blade 15 (2019), the plan still works but NVIDIA drivers should target older RTX 20xx series (use `hardware.nvidia.open = false` with proprietary).

**Clarify with user before execution:** exact model year and CPU/GPU variant.

---

## Current Context / Assumptions

### Repository
- Flake repo: `D:\Source\Repos\GitHub.com\shikanime\shikanime`
- Existing hosts: `ashira`, `manash`, `nalsha` (x86 cluster nodes), `nixtar` (WSL workstation), `catbox` (Docker devcontainer), `telsha` (nix-darwin)
- Closest reference hosts: **nixtar** (workstation, NVIDIA, shika user), **ashira** (x86 hardware, disko, systemd-boot, sops-nix)
- User `shika` is the workstation user (used on nixtar, catbox). Home config mirrors nixtar's with full dev tooling.

### VCS
- Always use **jj** (jujutsu). Create workspace with `jj git init --colocate`.
- `ghstack land` / `jj git push` strip GPG signatures. For signed commits, push raw SHA via `git push origin <sha>:refs/heads/<branch>`.
- Use GPG key EA3CE20AC83A347C for manifests/shikanime repo (via jj).

### Dual-Boot Constraints
- **No disko** — Windows partitions must be preserved. Manual partitioning at install time (shrink Windows, create NixOS partitions).
- **systemd-boot** (used by ashira) does NOT auto-detect Windows. Must add a manual `boot.loader.systemd-boot.windows` entry, OR switch to **GRUB** with `os-prober`.
- Decision: **systemd-boot with manual Windows entry** — simpler, matches existing hosts, systemd-boot can chainload `\EFI\Microsoft\Boot\bootmgfw.efi`.

### NVIDIA
- RTX 40/50 series: use `hardware.nvidia.open = true` (open kernel modules are recommended for Turing+). nixtar already uses this.
- Enable `hardware.nvidia-container-toolkit` for Docker GPU passthrough (nixtar pattern).

---

## Step-by-Step Plan

### Task 1: Add `nixos-hardware` Flake Input

**Objective:** Add the nixos-hardware input to `flake.nix` so hardware-specific modules are available.

**Files:**
- Modify: `flake.nix` (inputs section, around line 72)

**Step 1: Add the input**

In `flake.nix`, after the `nixos-wsl` input block (line 70) and before `nixpkgs` (line 72), add:

```nix
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
    };
```

Note: `nixos-hardware` does NOT follow nixpkgs (it pins its own for module evaluation). Do not add `inputs.nixpkgs.follows`.

**Step 2: Update flake.lock**

Run: `nix flake lock --update-input nixos-hardware` (from within the repo, on a NixOS machine or nix-enabled environment)

Expected: `flake.lock` updated with nixos-hardware input.

**Step 3: Commit**

```bash
jj describe -m "feat: add nixos-hardware flake input for Ishtar host"
```

---

### Task 2: Create Host Directory Structure

**Objective:** Create the directory skeleton for `hosts/ishtar/`.

**Files:**
- Create: `hosts/ishtar/configuration.nix` (empty placeholder — filled in Task 3)
- Create: `hosts/ishtar/users/shika/home-configuration.nix` (empty placeholder — filled in Task 5)

**Step 1: Create directories**

```bash
mkdir -p hosts/ishtar/users/shika
```

**Step 2: Create placeholder files** (will be filled by subsequent tasks)

---

### Task 3: Write `hosts/ishtar/configuration.nix`

**Objective:** Full hardware + system configuration for the Razer Blade 16 dual-boot workstation.

**Files:**
- Create: `hosts/ishtar/configuration.nix`

**Step 1: Write the configuration**

```nix
{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    # nixos-hardware common modules for Blade 16 (no Blade-16-specific module exists yet)
    # nixos-hardware.nixosModules.common-cpu-intel   # uncomment for Intel variant
    # nixos-hardware.nixosModules.common-cpu-amd     # uncomment for AMD 2025 variant
    # nixos-hardware.nixosModules.common-gpu-nvidia
    # nixos-hardware.nixosModules.common-pc-laptop-ssd
    # nixos-hardware.nixosModules.common-hidpi

    ../../modules/nixos/base.nix
    ../../modules/nixos/workstation.nix
  ];

  # ── Boot ─────────────────────────────────────────────────────────
  boot = {
    kernelModules = [
      "tcp_bbr"
      "vhost_vsock"          # virtio for VMs
    ];

    kernel.sysctl = {
      # Workstation performance tuning (from nixtar pattern)
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 524288;

      "fs.inotify.max_user_watches" = 524288;
      "fs.inotify.max_user_instances" = 512;
      "fs.file-max" = 2097152;

      "net.core.default_qdisc" = "fq";
      "net.core.netdev_max_backlog" = 16384;
      "net.core.rmem_default" = 7340032;
      "net.core.rmem_max" = 16777216;
      "net.core.somaxconn" = 65535;
      "net.core.wmem_default" = 7340032;
      "net.core.wmem_max" = 16777216;
      "net.ipv4.ip_local_port_range" = "1024 65535";
      "net.ipv4.tcp_congestion_control" = "bbr";
      "net.ipv4.tcp_fin_timeout" = 30;
      "net.ipv4.tcp_keepalive_time" = 600;
      "net.ipv4.tcp_mtu_probing" = 1;
      "net.ipv4.tcp_rmem" = "4096 87380 16777216";
      "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    };

    # Dual-boot: systemd-boot with manual Windows entry
    # systemd-boot does NOT auto-detect Windows (unlike GRUB os-prober)
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        # Add Windows Boot Manager to the boot menu
        windows."11".efiDeviceHandle = "HD4";  # ⚠️ Verify handle with `efibootmgr` on target machine
      };
    };
  };

  # ── Filesystems (manual partitioning — dual boot, no disko) ──────
  # These will be generated by `nixos-generate-config` at install time.
  # Replace placeholder device paths with actual values from the machine.
  # Windows occupies its own partitions — do NOT touch them.
  #
  # Example layout (adjust to actual partitioning):
  # /dev/nvme0n1p1  EFI System Partition (shared with Windows or separate)
  # /dev/nvme0n1p2  Windows recovery
  # /dev/nvme0n1p3  Windows OS (NTFS)
  # /dev/nvme0n1p4  NixOS root (btrfs or ext4)
  # /dev/nvme0n1p5  NixOS home (btrfs subvolume or separate partition)
  # /dev/nvme0n1p6  NixOS swap

  # ── Hardware ─────────────────────────────────────────────────────
  hardware = {
    enableRedistributableFirmware = true;

    # NVIDIA RTX 40/50 series — open kernel modules
    nvidia = {
      open = true;

      # Hybrid graphics: use NVIDIA Optimus / PRIME
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        # ⚠️ Bus IDs must be detected on the actual machine with `nvidia-smi -q` or lspci
        # Example for typical Blade 16 layout:
        intelBusId = "PCI:0:2:0";      # iGPU
        nvidiaBusId = "PCI:1:0:0";     # dGPU
      };

      # Power management for suspend/resume reliability
      powerManagement = {
        enable = true;
        finegrained = true;
      };
    };

    nvidia-container-toolkit = {
      enable = true;
      mount-nvidia-executables = false;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Bluetooth (Razer Blade 16 has Intel AX211/Wi-Fi 6E)
    bluetooth.enable = true;
  };

  # OpenRazer for Razer keyboard lighting and laptop peripheral control
  hardware.openrazer = {
    enable = true;
    users = [ "shika" ];
  };

  # ── Networking ───────────────────────────────────────────────────
  networking = {
    hostName = "ishtar";
    networkmanager.enable = true;  # Laptop — needs NetworkManager for Wi-Fi
    firewall.enable = true;
  };

  # ── Desktop Environment ──────────────────────────────────────────
  # Decision point: GNOME (simple, Wayland-native, works well with NVIDIA)
  # or leave DE choice to user. Defaulting to GNOME for out-of-box experience.
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    desktopManager.gnome.enable = true;
    displayManager.gdm.wayland = true;
  };

  # ── Programs ─────────────────────────────────────────────────────
  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.stdenv.cc.cc.lib
      pkgs.zlib
    ];
  };

  environment.systemPackages = with pkgs; [
    docker-credential-helpers
    dunst
    libnotify
    polychromatic         # OpenRazer GUI for lighting control
    wl-clipboard
  ];

  # ── Services ─────────────────────────────────────────────────────
  services = {
    openssh = {
      enable = true;
      openFirewall = true;
    };

    tailscale = {
      enable = true;
      openFirewall = true;
      authKeyFile = config.sops.secrets.tailscale-authkey.path;
      extraUpFlags = [
        "--accept-routes"
        "--ssh"
      ];
    };

    # Firmware updates
    fwupd.enable = true;

    # Auto-login for laptop convenience (optional)
    # displayManager.autoLogin = {
    #   enable = true;
    #   user = "shika";
    # };
  };

  # ── Virtualisation ───────────────────────────────────────────────
  virtualisation.docker = {
    autoPrune.enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings.features.cdi = true;
    };
  };

  # ── Users ────────────────────────────────────────────────────────
  users.users.shika = {
    extraGroups = [ "wheel" "openrazer" "docker" "networkmanager" ];
    isNormalUser = true;
    home = "/home/shika";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+tp1Xfz7NomHCZuDPlfj3XW5hm9t0TiCyEeudRraoe"
    ];
  };

  home-manager.users.shika.imports = [
    ./users/shika/home-configuration.nix
  ];

  # ── Secrets (sops-nix) ───────────────────────────────────────────
  sops = {
    age = {
      generateKey = true;
      keyFile = "/var/lib/sops-nix/key.txt";
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    };
    defaultSopsFile = ../../secrets/ishtar.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      tailscale-authkey = { };
      nix-access-token = { };
    };
    templates.nix-config.content = ''
      extra-access-tokens = "github.com=${config.sops.placeholder.nix-access-token}";
    '';
  };

  nix.extraOptions = ''
    !include ${config.sops.templates.nix-config.path}
  '';

  # ── SSH host config for workstation ──────────────────────────────
  # Add ishtar to known hosts in modules/home/workstation.nix? No — that's
  # home-manager. Add to the ssh config block there if remote access is needed.
}
```

**Step 2: Verify the file parses (if nix is available)**

Run: `nix eval .#nixosConfigurations.ishtar.config.system.build.toplevel --dry-run 2>&1 | head -20`
Expected: No parse errors (may fail on evaluation until Task 6 registers it).

**Step 3: Commit**

```bash
jj describe -m "feat(ishtar): add Razer Blade 16 hardware configuration"
```

---

### Task 4: Add Ishtar to `modules/flake/nixos.nix`

**Objective:** Register the ishtar nixosConfiguration and package in the flake outputs.

**Files:**
- Modify: `modules/flake/nixos.nix`

**Step 1: Add nixosConfiguration**

After the `nixtar` block (around line 80, before the closing `};`), add:

```nix
      ishtar = inputs.nixpkgs.lib.nixosSystem {
        pkgs = import inputs.nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        modules = [
          ../../hosts/ishtar/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops
          inputs.nixos-hardware.nixosModules.common-cpu-intel
          inputs.nixos-hardware.nixosModules.common-gpu-nvidia
          inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd
          inputs.nixos-hardware.nixosModules.common-hidpi
          {
            home-manager.sharedModules = [
              inputs.catppuccin.homeModules.default
              inputs.colemak.homeModules.default
              inputs.devlib.homeModules.default
              inputs.sops-nix.homeModules.default
            ];
          }
        ];
      };
```

⚠️ **nixos-hardware modules are imported here** (not in configuration.nix) because they need to come from the flake input. The commented-out imports in `configuration.nix` (Task 3) are placeholders — the actual imports happen here.

If the machine is the AMD variant, change `common-cpu-intel` to `common-cpu-amd`.

**Step 2: Add package output**

In the `packages.x86_64-linux` block (around line 109, after `nixtar`), add:

```nix
        ishtar = self.nixosConfigurations.ishtar.config.system.build.toplevel;
```

**Step 3: Verify flake evaluates**

Run: `nix flake show` (from repo root)
Expected: `nixosConfigurations.ishtar` appears in output.

**Step 4: Commit**

```bash
jj describe -m "feat(ishtar): register nixosConfiguration and package in flake"
```

---

### Task 5: Write `hosts/ishtar/users/shika/home-configuration.nix`

**Objective:** Home-manager configuration for the shika user on Ishtar — mirrors nixtar's full dev workstation setup.

**Files:**
- Create: `hosts/ishtar/users/shika/home-configuration.nix`

**Step 1: Write the configuration**

This mirrors the nixtar home-configuration pattern exactly, with ishtar-specific secrets file:

```nix
{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  toDhall = generators.toDhall { };

  gitIni = pkgs.formats.gitIni { };
  ini = pkgs.formats.ini { };
  toml = pkgs.formats.toml { };
  yaml = pkgs.formats.yaml { };

  name = "William Phetsinorath";
  signingKey = "721388256B3D78FA";
in
{
  imports = [
    ../../../../modules/home/base.nix
    ../../../../modules/home/cloud.nix
    ../../../../modules/home/fontconfig.nix
    ../../../../modules/home/helix.nix
    ../../../../modules/home/starship.nix
    ../../../../modules/home/vcs.nix
    ../../../../modules/home/workstation.nix
    ../../../../modules/home/zed-editor.nix
  ];

  home.sessionVariables.GHSTACKRC_PATH = config.lib.file.mkOutOfStoreSymlink config.sops.templates.ghstack-config.path;

  nix.extraOptions = ''
    !include ${config.sops.templates.nix-config.path}
  '';

  programs = {
    bash.enable = true;

    docker-cli.settings.credsStore = "pass";

    git = {
      includes = [
        { path = config.lib.file.mkOutOfStoreSymlink config.sops.templates.git-config.path; }
      ];
      signing = {
        format = "openpgp";
        signByDefault = true;
      };
    };
  };

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ../../../../secrets/ishtar.enc.yaml;
    defaultSopsFormat = "yaml";
    secrets = {
      cachix-token = { };
      github-token = { };
      gitlab-token = { };
      gouv-email = { };
      gouv-signing-key = { };
      shikanime-studio-email = { };
      nix-access-token = { };
    };
    templates = {
      cachix-config.content = toDhall {
        authToken = config.sops.placeholder.cachix-token;
        hostname = "https://cachix.org";
      };
      ghstack-config = {
        file = ini.generate "ghstackrc" {
          ghstack = {
            github_oauth = config.sops.placeholder.github-token;
            github_url = "github.com";
            github_username = "shikanime";
          };
        };
        mode = "0640";
      };
      glab-cli-config.file = yaml.generate "config.yaml" {
        git_protocol = "https";
        hosts.gitlab.com = {
          api_host = "gitlab.com";
          api_protocol = "https";
          token = config.sops.placeholder.gitlab-token;
        };
      };
      git-config.file = gitIni.generate "config" {
        user = {
          inherit name;
          inherit signingKey;
          email = config.sops.placeholder.shikanime-studio-email;
        };
      };
      jujutsu-config.file = toml.generate "config.toml" {
        "--scope" = [
          {
            "--when.repositories" = [ "~/Source/Repos/github.com/cloud-pi-native" ];
            signing.key = config.sops.placeholder.gouv-signing-key;
            user = {
              email = config.sops.placeholder.gouv-email;
              inherit name;
            };
          }
        ];
        signing = {
          backend = "gpg";
          behavior = "own";
          key = signingKey;
        };
        user = {
          inherit name;
          email = config.sops.placeholder.shikanime-studio-email;
        };
      };
      nix-config.content = ''
        extra-access-tokens = "github.com=${config.sops.placeholder.nix-access-token}";
      '';
      sapling-config.file = ini.generate "sapling.conf" {
        alias = {
          ci = "ci --message-field Signed-off-by=\"${name} <${config.sops.placeholder.shikanime-studio-email}>\"";
          commit = "commit --message-field Signed-off-by=\"${name} <${config.sops.placeholder.shikanime-studio-email}>\"";
          push = "push --force";
        };
        committemplate = {
          commit-message-fields = "Summary,Fixes,Signed-off-by";
          emptymsg = "{if(title, title, defaulttitle)}\\n\\nSummary: {summary}\\n\\nFixes: {fixes}\\n\\nSigned-off-by: {author}";
        };
        diff-tools = {
          "zed.args" = "--wait --diff $local $other";
          "zed.gui" = true;
          "zed.priority" = 20;
        };
        gpg.key = signingKey;
        hooks = {
          "precommit.git-hooks" = "test -f .git/hooks/pre-commit && .git/hooks/pre-commit || true";
          "preoutgoing.git-hooks" = "test -f .git/hooks/pre-push && .git/hooks/pre-push || true";
          "update.git-hooks" = "test -f .git/hooks/post-rewrite && .git/hooks/post-rewrite || true";
        };
        merge-tools = {
          "mergiraf.args" = "merge --git $base $local $other -o $output";
          "mergiraf.priority" = 30;
        };
        ui = {
          editor = "hx";
          username = "${name} <${config.sops.placeholder.shikanime-studio-email}>";
        };
      };
    };
  };

  xdg.configFile = {
    "cachix/cachix.dhall".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.templates.cachix-config.path;
    "glab-cli/config.yml" = {
      force = true;
      source = config.lib.file.mkOutOfStoreSymlink config.sops.templates.glab-cli-config.path;
    };
    "jj/conf.d/default.toml".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.templates.jujutsu-config.path;
    "sapling/sapling.conf".source =
      config.lib.file.mkOutOfStoreSymlink config.sops.templates.sapling-config.path;
  };
}
```

**Step 2: Commit**

```bash
jj describe -m "feat(ishtar): add shika home-manager configuration"
```

---

### Task 6: Add SSH Host Entry to `modules/home/workstation.nix`

**Objective:** Add ishtar to the SSH known-hosts list so other machines can connect.

**Files:**
- Modify: `modules/home/workstation.nix` (the `programs.ssh.settings` block)

**Step 1: Add the entry**

In the `programs.ssh.settings` block, after the `nalsha` entry (around line 102), add:

```nix
        "ishtar.taila659a.ts.net" = {
          User = "shika";
          SetEnv.TERM = "xterm-256color";
        };
```

**Step 2: Commit**

```bash
jj describe -m "feat(ishtar): add ishtar to SSH known hosts"
```

---

### Task 7: Create sops-nix Secrets Template

**Objective:** Create the encrypted secrets file `secrets/ishtar.enc.yaml` with the required secret keys.

**Files:**
- Create: `secrets/ishtar.enc.yaml` (sops-encrypted)

**Step 1: Create the sops file**

This must be done from a machine with sops and the age/SSH keys configured:

```bash
# Create the secrets file with all required keys
sops secrets/ishtar.enc.yaml
```

The file needs these keys (matching configuration.nix and home-configuration.nix):

```yaml
tailscale-authkey: ""
nix-access-token: ""
cachix-token: ""
github-token: ""
gitlab-token: ""
gouv-email: ""
gouv-signing-key: ""
shikanime-studio-email: ""
```

**Step 2: Verify sops config**

Create or update `.sops.yaml` at repo root to include the ishtar age/SSH key:

```yaml
creation_rules:
  - path_regex: secrets/ishtar\.enc\.yaml$
    encrypted_regex: '^(data|stringData)$'
    age: "<ishtar-age-public-key>"
```

⚠️ The age key is generated at first boot (`hardware.age.generateKey = true`). For initial creation, use the SSH host key or a pre-generated age key.

**Step 3: Commit**

```bash
jj describe -m "feat(ishtar): add encrypted secrets template"
```

---

### Task 8: Push and Create PR

**Objective:** Push the changes and open a PR via the established jj + gh workflow.

**Step 1: Squash all ishtar commits**

```bash
jj log
# Squash related commits if needed
jj describe -m "feat(ishtar): add NixOS host for Razer Blade 16 dual-boot workstation"
```

**Step 2: Push (raw SHA fallback for signed commits)**

```bash
SHA=$(jj log -r @ --no-graph -T 'change_id.short()')
git push origin ${SHA}:refs/heads/feat/ishtar-host
```

**Step 3: Create PR**

```bash
gh pr create --head feat/ishtar-host \
  --title "feat: add Ishtar host (Razer Blade 16 dual-boot)" \
  --body "New NixOS workstation host for Razer Blade 16 with dual-boot Windows support.

Hardware: NVIDIA RTX 40/50 + Intel/AMD, OpenRazer, GNOME.
Follows existing nixtar workstation pattern.
Uses systemd-boot with manual Windows UEFI entry."
```

---

## Files Likely to Change

| File | Action | Description |
|------|--------|-------------|
| `flake.nix` | Modify | Add `nixos-hardware` input |
| `flake.lock` | Modify | Lock the new input |
| `modules/flake/nixos.nix` | Modify | Register `ishtar` nixosConfiguration + package |
| `hosts/ishtar/configuration.nix` | Create | Hardware + system config |
| `hosts/ishtar/users/shika/home-configuration.nix` | Create | Home-manager config |
| `secrets/ishtar.enc.yaml` | Create | sops-nix encrypted secrets |
| `modules/home/workstation.nix` | Modify | Add SSH host entry |
| `.sops.yaml` | Modify (if exists) | Add ishtar creation rule |

---

## Verification Steps

1. **Flake evaluation:** `nix flake show` — confirms `nixosConfigurations.ishtar` exists
2. **Build dry-run:** `nix build .#nixosConfigurations.ishtar.config.system.build.toplevel --dry-run`
3. **Full build (on NixOS machine):** `nix build .#nixosConfigurations.ishtar.config.system.build.toplevel`
4. **Home-manager check:** `nix run .#home-manager -- build --flake .#shika@ishtar`
5. **Install on hardware:** Boot NixOS USB → partition → `nixos-install --flake github:shikanime/shikanime#ishtar`
6. **Dual-boot verify:** After install, `efibootmgr` should show both NixOS and Windows Boot Manager entries
7. **NVIDIA verify:** `nvidia-smi` works, `glxinfo | grep "OpenGL renderer"` shows NVIDIA
8. **OpenRazer verify:** `polychromatic` launches, keyboard lighting responds
9. **Tailscale verify:** `tailscale status` shows connected

---

## Risks, Tradeoffs, and Open Questions

### Risks

1. **NVIDIA Bus IDs** — `intelBusId` and `nvidiaBusId` are placeholders. Must detect with `lspci -nn | grep -E 'VGA|3D'` on the actual machine. Wrong IDs = black screen on boot.

2. **systemd-boot Windows entry** — `boot.loader.systemd-boot.windows."11".efiDeviceHandle` is a guess (`HD4`). Must verify with `efibootmgr -v` on the actual machine. If it doesn't work, alternative is to rely on UEFI boot menu (F12 at boot on Razer).

3. **NVIDIA open vs proprietary** — `open = true` is recommended for RTX 40/50 (Turing+). If experiencing issues, switch to `open = false` for proprietary.

4. **No disko** — Dual-boot means manual partitioning at install time. This is inherently more error-prone. Document the expected layout carefully.

5. **Blade 16 thermal management** — Razer laptops run hot. Consider adding `thermald` (Intel) or `power-profiles-daemon`. The nixos-hardware `common-pc-laptop` module may handle some of this.

6. **OLED screen burn-in** — GNOME on OLED should enable screen blanking. Consider adding `dconf` settings for shorter idle time.

### Tradeoffs

- **systemd-boot vs GRUB:** systemd-boot chosen for consistency with existing hosts (ashira). GRUB with os-prober would auto-detect Windows but breaks the pattern.
- **GNOME vs no DE:** GNOME chosen as default for laptop usability. User may prefer to swap for a tiling WM later.
- **btrfs vs ext4:** Left to install-time decision. btrfs enables snapshots but adds complexity.

### Open Questions

1. **Which Blade 16 model exactly?** (2024 Intel vs 2025 AMD — affects CPU module choice and NVIDIA variant)
2. **Desktop environment preference?** (GNOME default, or KDE/tiling WM?)
3. **Filesystem choice for NixOS root?** (btrfs with snapshots vs ext4)
4. **Shared EFI partition with Windows?** (Usually fine — both mount FAT32 ESP)
5. **Does the user want hermes-agent service enabled on this host?** (Like cluster nodes — see `modules/nixos/ai.nix`)
6. **Remote build machine?** (Building a full NixOS system with NVIDIA + GNOME is heavy — consider remote build from an existing cluster node)

---

## Post-Install Tasks (Not Part of This Plan)

- Generate `facter.json` with `nixos-facter` on the actual machine (like ashira/nixtar have)
- Adjust Bus IDs based on `lspci` output
- Adjust EFI device handle for Windows based on `efibootmgr`
- Add ishtar as a remote build machine in `modules/nixos/distributed.nix` (if applicable)
- Consider adding `services.hardware.bolt.enable = true` for Thunderbolt support
