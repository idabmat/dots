{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hyprland.nix
    ./git.nix
    ./shell.nix
    ./kitty.nix
    ./nvim/config.nix
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "slack"
      "discord"
      "joypixels"
      "zoom"
      "graphite-cli"
      "spotify"
      "ngrok"
      "android-studio-stable"
    ];
  nixpkgs.config.joypixels.acceptLicense = true;

  home = {
    username = "me";
    homeDirectory = "/home/me";
    stateVersion = "23.11";
    packages = [
      pkgs.kitty
      pkgs.lsd
      pkgs.yubikey-manager
      pkgs.pcsclite
      pkgs.qdigidoc
      pkgs.p11-kit
      pkgs.opensc
      pkgs.web-eid-app
      pkgs.pavucontrol
      pkgs.wl-clipboard
      pkgs.libnotify
      pkgs.zed-editor
      (pkgs.ruby.withPackages (ps: with ps; [ thor solargraph ]))
      pkgs.python3
      pkgs.btop
      pkgs.silver-searcher
      pkgs.ripgrep
      pkgs.grim
      pkgs.slurp
      pkgs.bemoji
      pkgs.cliphist
      pkgs.slack
      pkgs.discord
      pkgs.joypixels
      pkgs.xdg-utils
      pkgs.spotify
      pkgs.ags
      pkgs.pulseaudio
      pkgs.ngrok
      pkgs.whatsapp-for-linux
      pkgs.zathura
      pkgs.mpvpaper
      pkgs.oculante
      pkgs.gimp
      pkgs.inkscape
      pkgs.gnome.gvfs
      pkgs.nautilus
      pkgs.zeal
      pkgs.gtk-engine-murrine
      pkgs.nwg-look
      pkgs.mplayer
      pkgs.brightnessctl
      pkgs.hyprpaper
      pkgs.hyprlock
      pkgs.hypridle
      pkgs.zoom-us
      pkgs.hyprcursor
      pkgs.inotify-tools
      pkgs.lua-language-server
      pkgs.nixpkgs-fmt
      pkgs.nixd
      pkgs.graphite-cli
      pkgs.nodePackages_latest.typescript-language-server
      pkgs.tailwindcss-language-server
      pkgs.yaml-language-server
      pkgs.terraform-ls
      pkgs.vscode-langservers-extracted
      pkgs.android-tools
      pkgs.android-studio
      pkgs.chromium
      pkgs.chromedriver
      (pkgs.writeScriptBin "2fa" (builtins.readFile ./scripts/2fa))
      pkgs.winetricks
      pkgs.wineWowPackages.waylandFull
    ];
    file = {
      ".local/bin/elixir-ls" = {
        source = (pkgs.fetchzip {
          url = "https://github.com/elixir-lsp/elixir-ls/releases/download/v0.22.0/elixir-ls-v0.22.0.zip";
          hash = "sha256-7gB82wcPRG2ydrfxO/GIY2oD4dP7BWSI/2ecjYSpGAs=";
          stripRoot = false;
        });
        recursive = true;
      };
      ".local/bin/dagger" = {
        source = (pkgs.fetchzip {
          url = "https://github.com/dagger/dagger/releases/download/v0.11.8/dagger_v0.11.8_linux_amd64.tar.gz";
          hash = "sha256-QLcKVRE9Bg6/npw3hk6C01f9xvvb+Q8hBy6rLZrLPeQ=";
          stripRoot = false;
        });
      };
      ".local/share/icons/HyprBibataModernClassicSVG" = {
        source = ./assets/icons/HyprBibataModernClassicSVG;
        recursive = true;
      };
      ".config/ags" = {
        source = ./config/ags;
        recursive = true;
      };
      ".local/share/applications/rog-control-center.desktop" = {
        source = ./rog-control-center.desktop;
      };
    };
    activation = {
      regenerateTofiCache = lib.hm.dag.entryAfter [ "WriteBoundary" ] ''
        tofi_cache=${config.xdg.cacheHome}/tofi-drun
        [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
      '';
    };
    sessionVariables = {
      "NIXOS_OZONE_WL" = "1";
    };
    sessionPath = [
      "$HOME/.local/bin/docker"
      "$HOME/.local/bin/dagger"
      "$HOME/.local/bin/elixir-ls"
    ];
    pointerCursor = {
      gtk.enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 12;
    };
  };

  xdg = {
    configFile = {
      "kitty" = {
        source = ./config/kitty;
        recursive = true;
      };
      "hypr" = {
        source = ./config/hypr;
        recursive = true;
      };
    };
    portal = {
      enable = true;
      configPackages = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
      ];
    };
  };

  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.tela-icon-theme;
      name = "Tela-black-dark";
    };
    theme = {
      package = pkgs.graphite-gtk-theme;
      name = "Graphite-Dark";
    };
    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 12;
    };
    gtk3 = {
      bookmarks = [
        "file:///home/me/code"
        "file:///home/me/Downloads"
        "file:///home/me/Pictures"
      ];
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    gtk4 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = {
      name = "gtk3";
    };
    style = {
      name = "kvantum";
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
    bun = {
      enable = true;
      enableGitIntegration = true;
    };
    tofi = {
      enable = true;
      settings = {
        border-width = 2;
        border-color = "#cc241dee";
        outline-width = 0;
        corner-radius = 10;
        result-spacing = 20;
        prompt-padding = 10;
        background-color = "#000A";
        selection-color = "#cc241dee";
        history = true;
        padding-top = 30;
        padding-bottom = 30;
        padding-left = 60;
        padding-right = 60;
        ascii-input = true;
        drun-launch = true;
      };
    };
    firefox = {
      enable = true;
      profiles = {
        me = {
          id = 0;
          isDefault = true;
          name = "me";
        };
      };
      package = pkgs.firefox.override {
        nativeMessagingHosts = [
          pkgs.web-eid-app
        ];
      };
    };
  };

  services = {
    dunst = {
      enable = true;
    };
  };

  fonts.fontconfig.enable = true;
}
