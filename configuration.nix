# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  nixpkgs = {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
      };
    };
    initrd = {
      luks = {
        devices = {
          cryptlvm = {
            device = "/dev/disk/by-uuid/146caf35-05b1-4bb4-93af-34e0af81399a";
            preLVM = true;
            allowDiscards = true;
            keyFile = "/keyfile";
          };
	};
      };
      secrets = {
        "keyfile" = "/etc/secrets/keyfile";
      };
      kernelModules = [ "nvidia" ];
    };
    kernelParams = [
      "amd_pstate=active"
      "amdgpu.sg_display=0"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
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
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      prime = {
        amdgpuBusId = "PCI:9:0:0";
        nvidiaBusId = "PCI:1:0:0";
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
      };
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
      enable = true;  # Easiest to use and most distros use this by default.
    };
    firewall = {
      checkReversePath = "loose";
    };
  };

  time.timeZone = "Africa/Niamey";

  i18n.defaultLocale = "en_US.UTF-8";

  security = {
    rtkit = {
      enable = true;
    };
  };

  virtualisation = {
    docker = {
      enable = true;
    };
  };

  users = {
    users = {
      me = {
        isNormalUser = true;
        shell = pkgs.zsh;
        extraGroups = [ "wheel" "docker" ];
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      helix
    ];
    shells = with pkgs; [
      zsh
    ];
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = [
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
    };
  };

  programs = {
    hyprland =  {
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
      packages = [pkgs.yubikey-personalization];
    };
    xserver = {
      videoDrivers = ["nvidia"];
    };
    blueman = {
      enable = true;
    };
    ollama = {
      enable = true;
      acceleration = "cuda";
    };
    gvfs = {
      enable = true;
    };
    upower = {
      enable = true;
    };
    power-profiles-daemon = {
      enable = true;
    };
    supergfxd = {
      enable = true;
    };
    asusd = {
      enable = true;
      enableUserService = true;
    };
  };

  system.stateVersion = "23.11";
}

