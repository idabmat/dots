{
  pkgs,
  lib,
  users,
  hyprland,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      rocmSupport = true;
    };
    overlays = [
      (final: prev: {
        asusctl = prev.asusctl.overrideAttrs (old: {
          patches = (old.patches or []) ++ [./asusctl-power-zone-bounds.patch];
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
      substituters = ["https://hyprland.cachix.org"];
      trusted-substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
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
            crypttabExtraOpts = ["fido2-device=auto"];
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
  };

  security = {
    rtkit = {
      enable = true;
    };
    pam = {
      services = {
        hyprlock = {};
      };
    };
  };

  users = {
    users =
      lib.attrsets.mapAttrs (name: value: {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
        ];
      })
      users;
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
      supergfxd.path = [pkgs.pciutils];
      xhci-resume-fix = let
        dev = "0000:c4:00.4";
        rebind = pkgs.writeShellScript "xhci-rebind" ''
          echo ${dev} > /sys/bus/pci/drivers/xhci_hcd/unbind 2>/dev/null || true
          echo ${dev} > /sys/bus/pci/drivers/xhci_hcd/bind
        '';
        unbind = pkgs.writeShellScript "xhci-unbind" ''
          echo ${dev} > /sys/bus/pci/drivers/xhci_hcd/unbind 2>/dev/null || true
        '';
      in {
        description = "Rebind xHCI controller ${dev} around suspend to fix webcam resume";
        before = ["sleep.target"];
        after = ["suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
        wantedBy = ["sleep.target" "suspend.target" "hibernate.target" "hybrid-sleep.target" "suspend-then-hibernate.target"];
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
      packages = [pkgs.yubikey-personalization];
    };
    blueman = {
      enable = true;
    };
    llama-cpp = {
      enable = false;
      package = pkgs.llama-cpp-rocm;
      modelsPreset = {
        "qwen3.5-35b-a3b" = {
          hf-repo = "HauhauCS/Qwen3.5-35B-A3B-Uncensored-HauhauCS-Aggressive";
          hf-file = "Qwen3.5-35B-A3B-Uncensored-HauhauCS-Aggressive-Q4_K_M.gguf";
          alias = "qwen3.5-35b-a3b";
          temp = "1.0";
          top-p = "0.95";
          top-k = "20";
          min-p = "0.0";
          ctx-size = "131072";
          presence-penalty = "0.0";
          repeat-penalty = "1.0";
          jinja = "on";
          parallel = "1";
          load-on-startup = "on";
          no-mmap = "on";
          flash-attn = "on";
        };
      };
    };
  };

  virtualisation.docker.enable = true;

  system.stateVersion = "24.11";
}
