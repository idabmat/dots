# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

let
  zfsCompatibleKernelPackages = lib.filterAttrs (
    name: kernelPackages:
    (builtins.match "linux_[0-9]+_[0-9]+" name) != null
    && (builtins.tryEval kernelPackages).success
    && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken)
  ) pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  imports = [
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
    initrd = {
      kernelModules = [ "nvidia" ];
    };
    kernelParams = [
      "amd_pstate=active"
    ];
    kernelPackages = latestKernelPackage;
    supportedFilesystems = [ "zfs" ];
    zfs = {
      forceImportRoot = false;
      extraPools = [ "data" ];
    };
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting = {
        enable = true;
      };
      open = false;
      nvidiaSettings = true;
      powerManagement = {
        enable = true;
      };
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
  };

  networking = {
    networkmanager = {
      enable = true; # Easiest to use and most distros use this by default.
    };
    firewall = {
      checkReversePath = "loose";
    };
    hostId = "b756db4b";
  };

  time.timeZone = "Europe/Lisbon";

  i18n.defaultLocale = "en_US.UTF-8";

  security = {
    rtkit = {
      enable = true;
    };
  };

  users = {
    users = {
      me = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" ];
        openssh = {
          authorizedKeys = {
            keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPg+ljxM+kwwIyvSwIDf5oTDBgU5zA168oAcu4oo3KjW me"
              "sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPxaM6r4pYjD42iNlSCwhtkET8VteiX7f0Xxgxl0B5zTAAAABHNzaDo= me@MobileHome"
            ];
          };
        };
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      neovim
    ];
    shells = with pkgs; [
      zsh
    ];
  };

  nix = {
    package = pkgs.nixVersions.stable;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
    };
  };

  programs = {
    appimage = {
      enable = true;
      binfmt = true;
    };
    hyprland = {
      enable = true;
    };
    zsh = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = false;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = false;
    };
    dconf = {
      enable = true;
    };
  };

  # List services that you want to enable:
  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };
    pulseaudio = {
      enable = false;
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
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
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
    xserver = {
      videoDrivers = [ "nvidia" ];
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
      acceleration = "cuda";
    };
    gvfs = {
      enable = true;
    };
    openssh = {
      enable = true;
      ports = [ 2222 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AllowUsers = [ "me" ];
        PermitRootLogin = "no";
      };
    };
    zfs = {
      autoScrub = {
        enable = true;
      };
    };
  };

  system.stateVersion = "24.05";
}
