{
  pkgs,
  lib,
  users,
  hyprland,
  ...
}:
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      rocmSupport = true;
    };
    overlays = [
      (final: prev: {
        asusctl = prev.asusctl.overrideAttrs (old: {
          patches = (old.patches or [ ]) ++ [ ./asusctl-power-zone-bounds.patch ];
        });
      })
    ];
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };

  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom="PT"
    '';
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "amd_pstate=active"
      # Strix Halo: let the iGPU map 20 GiB of system RAM as GTT (pages × 4 KiB).
      # Default is half of RAM (~13.5 GiB), too small for a 27B model + KV cache.
      # amdgpu.gttsize is deprecated upstream in favour of this knob.
      "ttm.pages_limit=5242880"
    ];
    initrd = {
      kernelModules = [
        "vfat"
        "nls_cp437"
        "nls_iso8859-1"
        "usbhid"
      ];
      systemd = {
        enable = true;
      };
      luks = {
        devices = {
          "nixos-enc" = {
            device = "/dev/nvme0n1p2";
            preLVM = true;
            crypttabExtraOpts = [ "fido2-device=auto" ];
          };
        };
      };
    };
  };

  hardware = {
    wirelessRegulatoryDatabase = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
    };
    xpadneo = {
      enable = true;
    };
    keyboard = {
      zsa = {
        enable = true;
      };
    };
    sensor = {
      iio = {
        enable = true;
      };
    };
    i2c = {
      enable = true;
    };
  };

  networking = {
    hostName = "nixtab";
    networkmanager = {
      enable = true;
    };
    firewall = {
      checkReversePath = "loose";
    };
  };

  time = {
    timeZone = "Europe/Lisbon";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_IE.UTF-8";
    };
  };

  security = {
    rtkit = {
      enable = true;
    };
    pam = {
      services = {
        hyprlock = { };
      };
    };
  };

  users = {
    users = lib.attrsets.mapAttrs (name: value: {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "input"
        "networkmanager"
        "wheel"
        "docker"
      ];
    }) users;
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      clinfo
      vulkan-tools
      rocmPackages.rocm-smi
      amd-debug-tools
    ];
    shells = with pkgs; [
      zsh
    ];
    variables = {
      AMD_VULKAN_ICD = "RADV";
    };
  };

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      withUWSM = true;
    };
    zsh = {
      enable = true;
    };
    steam = {
      enable = true;
      gamescopeSession = {
        enable = true;
      };
    };
  };

  systemd = {
    services = {
      supergfxd.path = [ pkgs.pciutils ];
      # At boot the module's default ordering (network.target) let llama-server
      # start while amdgpu was still probing, so neither Vulkan nor ROCm saw the
      # GPU. Wait for udev to finish coldplug and retry quickly if it still races.
      llama-cpp = {
        wants = [ "systemd-udev-settle.service" ];
        after = [ "systemd-udev-settle.service" ];
        serviceConfig.RestartSec = lib.mkForce 5;
        environment.LLAMA_ARG_THINK_BUDGET_MESSAGE = "Reasoning budget exhausted. I will answer now with what I have.";
      };
      xhci-resume-fix =
        let
          dev = "0000:c4:00.4";
          rebind = pkgs.writeShellScript "xhci-rebind" ''
            echo ${dev} > /sys/bus/pci/drivers/xhci_hcd/unbind 2>/dev/null || true
            echo ${dev} > /sys/bus/pci/drivers/xhci_hcd/bind
          '';
          unbind = pkgs.writeShellScript "xhci-unbind" ''
            echo ${dev} > /sys/bus/pci/drivers/xhci_hcd/unbind 2>/dev/null || true
          '';
        in
        {
          description = "Rebind xHCI controller ${dev} around suspend to fix webcam resume";
          before = [ "sleep.target" ];
          after = [
            "suspend.target"
            "hibernate.target"
            "hybrid-sleep.target"
            "suspend-then-hibernate.target"
          ];
          wantedBy = [
            "sleep.target"
            "suspend.target"
            "hibernate.target"
            "hybrid-sleep.target"
            "suspend-then-hibernate.target"
          ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
            ExecStart = rebind;
            ExecStop = unbind;
          };
        };
    };
  };

  services = {
    supergfxd = {
      enable = true;
    };
    upower = {
      enable = true;
    };
    asusd = {
      enable = true;
    };
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    pipewire = {
      enable = true;
      pulse = {
        enable = true;
      };
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
    resolved = {
      enable = true;
    };
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --remember-session";
          user = "greeter";
        };
      };
    };
    pcscd = {
      enable = true;
    };
    udev = {
      packages = [ pkgs.yubikey-personalization ];
    };
    blueman = {
      enable = true;
    };
    llama-cpp = {
      enable = true;
      # Vulkan (RADV) uses the GTT heap natively; the HIP path on gfx1151 only
      # sees the 4 GiB BIOS carve-out unless GGML_CUDA_ENABLE_UNIFIED_MEMORY=1.
      package = pkgs.llama-cpp-vulkan;
      settings = {
        # Upcoming upstream default; 8080 collides with project dev servers.
        # Must match the opencode provider baseURL in users/me/home.nix.
        port = 9931;
        # Both GGUFs are fetched on first start into /var/cache/llama-cpp.
        hf-repo = "unsloth/Qwen3.8-27B-GGUF:UD-Q3_K_XL"; # ~13.1 GB
        hf-repo-draft = "z-lab/Qwen3.8-27B-DFlash2-GGUF:Q4_K_M"; # ~1.1 GB
        # Speculative decoding: DFlash2 block drafter. Measured 2026-09-11 on
        # this machine (temperature 0, 400 tokens, RADV; serial = 15 tok/s):
        #   n-max 7: code 23  / prose 15    draft-mtp (built-in head, no
        #   n-max 5: code 29  / prose 19      drafter file): code 25 / prose 19
        #   n-max 3: code 27  / prose 22
        # An 8-token verify costs ~2x a serial step on RADV (pp8 = 61 tok/s vs
        # pp1 = 15.5), so smaller blocks win. 5 is tuned for opencode/code.
        spec-type = "draft-dflash";
        spec-draft-n-max = 5;
        device = "Vulkan0"; # skip llvmpipe; ROCm0 decodes 20% slower here
        # The DFlash2 GGUF borrows the target's output.weight (LM head). This
        # binary exposes both ROCm0 and Vulkan0, and an unpinned draft context
        # picks a different device than the target, which aborts in
        # ggml_backend_sched_split_graph ("pre-allocated tensor (output.weight)
        # ... cannot run the operation"). The drafter must sit on the target's
        # device (CPU drafting aborts the same way).
        spec-draft-device = "Vulkan0";
        n-gpu-layers = 999;
        spec-draft-ngl = 999;
        flash-attn = "on";
        jinja = true;
        # Text only: the unsloth repo ships an mmproj that --hf-repo auto-loads,
        # costing ~1 GiB of GPU memory and disabling cache-reuse.
        no-mmproj = true;
        # Memory budget (24 GiB Vulkan heap = 20 GiB GTT + 4 GiB carve-out):
        # 12.2 GiB model + 1.1 GiB drafter + KV. Qwen3.8-27B has 16 attention
        # layers x 4 KV heads x 256 dims = 64 KiB/token in f16, so q8_0 KV at
        # 128k costs the same ~4.3 GiB as f16 at 64k. Opencode's first request
        # alone was 37k tokens, so 64k compacted after a few tool calls.
        ctx-size = 131072;
        cache-type-k = "q8_0";
        cache-type-v = "q8_0";
        spec-draft-type-k = "q8_0";
        spec-draft-type-v = "q8_0";
        # Fail loudly instead of silently offloading layers / shrinking ctx.
        fit = "off";
        # Thinking is on by default and grew to 4-5k tokens per step (3-5 min
        # at ~18 tok/s) in agentic sessions. Cap it; the model still answers.
        # (The message is set via LLAMA_ARG_THINK_BUDGET_MESSAGE in the unit:
        # the module does not quote values containing spaces.)
        reasoning-budget = 4096;
        parallel = 1;
        # Prompt cache: keep every slot's KV resident and reuse interior chunks
        # so a follow-up turn only prefills the appended tokens.
        cache-ram = -1;
        cache-reuse = 256;
        # Qwen3.8 recommended sampling.
        temp = 1.0;
        top-p = 0.95;
        top-k = 20;
      };
    };
  };

  virtualisation = {
    spiceUSBRedirection = {
      enable = true;
    };
    docker = {
      enable = false;
      rootless = {
        enable = true;
        setSocketVariable = true;
        daemon = {
          settings = {
            dns = [
              "1.1.1.1"
              "8.8.8.8"
            ];
          };
        };
      };
    };
  };

  system.stateVersion = "24.11";
}
