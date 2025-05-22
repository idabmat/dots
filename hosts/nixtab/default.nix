{
  pkgs,
  lib,
  users,
  ...
}:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      rocmSupport = true;
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
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
      luks = {
        yubikeySupport = true;
        devices = {
          "nixos-enc" = {
            device = "/dev/nvme0n1p2";
            preLVM = true;
            yubikey = {
              slot = 2;
              twoFactor = true;
              storage = {
                device = "/dev/nvme0n1p1";
              };
            };
          };
        };
      };
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
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
  };

  networking = {
    hostName = "nixtab";
    networkmanager = {
      enable = true;
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
  };

  users = {
    users = lib.attrsets.mapAttrs (name: value: {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    }) users;
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
      clinfo
      vulkan-tools
      rocmPackages.rocm-smi
    ];
    shells = with pkgs; [
      zsh
    ];
  };

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    zsh = {
      enable = true;
    };
  };

  systemd.services.supergfxd.path = [ pkgs.pciutils ];

  services = {
    supergfxd = {
      enable = true;
    };
    asusd = {
      enable = true;
      enableUserService = true;
    };
    tailscale = {
      enable = true;
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
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
    hardware = {
      openrgb = {
        enable = true;
      };
    };
    ollama = {
      enable = true;
      acceleration = "rocm";
      environmentVariables = {
        HCC_AMDGPU_TARGET = "gfx1151";
      };
      rocmOverrideGfx = "11.0.1";
    };
  };

  system.stateVersion = "24.11";
}
