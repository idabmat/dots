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
      ];
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
        hyprlock = { };
      };
    };
  };

  users = {
    users = lib.attrsets.mapAttrs (name: value: {
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [
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
          command = "${pkgs.tuigreet}/bin/tuigreet --time";
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

  virtualisation.docker.enable = true;

  system.stateVersion = "24.11";
}
