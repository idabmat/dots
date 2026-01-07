{
  config,
  pkgs,
  lib,
  mcp-hub,
  mcphub-nvim,
  hyprland,
  ...
}:

let
  nvim = config.lib.file.mkOutOfStoreSymlink /home/me/.config/home-manager/users/me/nvim;
  hypr = config.lib.file.mkOutOfStoreSymlink /home/me/.config/home-manager/users/me/hypr;
in
{
  home = {
    username = "me";
    homeDirectory = "/home/me";
    stateVersion = "24.11";
    packages = with pkgs; [
      fastfetch
      lsd
      tree
      graphite-cli
      python3
      exercism
      btop
      ps
      unzip
      silver-searcher
      devbox
      ripgrep
      walker
      bitwarden-desktop
      yubikey-manager
      yubioath-flutter
      slack
      discord
      wl-clipboard
      openrgb
      flyctl
      mplayer
      timg
      pavucontrol
      brightnessctl
      playerctl
      rose-pine-cursor
      kdePackages.qtwayland
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      adw-gtk3
      adwaita-icon-theme
      nautilus
      aichat
      jq
      cantarell-fonts
      nerd-fonts.caskaydia-cove
      slurp
      grim
      gimp
      swaynotificationcenter
      spotify
      iio-hyprland
      mcp-hub.packages.${pkgs.stdenv.hostPlatform.system}.default
      sshuttle
      kooha
      wvkbd
      nwg-drawer
      iw
      claude-code
    ];
    file = {
      ".p10k.zsh" = {
        source = ./p10k.zsh;
      };
    };
    pointerCursor = {
      gtk = {
        enable = true;
      };
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 32;
    };
    activation = {
      generateCompletions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        mkdir -p ${config.home.homeDirectory}/.cache/oh-my-zsh/completions
        ${pkgs.devbox}/bin/devbox completion zsh > ${config.home.homeDirectory}/.cache/oh-my-zsh/completions/_devbox
        ${pkgs.graphite-cli}/bin/gt completion zsh > ${config.home.homeDirectory}/.cache/oh-my-zsh/completions/_gt
        ${pkgs.exercism}/bin/exercism completion zsh > ${config.home.homeDirectory}/.cache/oh-my-zsh/completions/_exercism
      '';
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";
    };

    iconTheme = {
      package = pkgs.dracula-icon-theme;
      name = "Dracula";
    };

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
    ashell = {
      enable = true;
      systemd = {
        enable = true;
      };
      settings = {
        appearance = {
          scale_factor = 1.5;
        };
        modules = {
          left = [ "Workspaces" ];
          center = [ "Clock" ];
          right = [
            "SystemInfo"
            "MediaPlayer"
            [
              "Tray"
              "Settings"
            ]
          ];
        };
      };
    };
    jujutsu = {
      enable = true;
      settings = {
        user = {
          email = "igor@talimhq.com";
          name = "Igor de Alcantara Barroso";
        };
        signing = {
          behavior = "own";
          backend = "gpg";
          key = "794A41BA3DBE9931";
        };
        ui = {
          pager = "delta";
        };
      };
    };
    git = {
      settings = {
        user = {

          email = "igor@talimhq.com";
          name = "Igor de Alcantara Barroso";
          github = {
            user = "idabmat";
          };
          pull = {
            rebase = false;
          };
          merge = {
            confictstyle = "diff3";
          };
          init = {
            defaultBranch = "main";
          };
          pager = {
            diff = "delta";
            log = "delta";
            reflog = "delta";
            show = "delta";
          };
        };
      };
      enable = true;
      signing = {
        key = "794A41BA3DBE9931";
        signByDefault = true;
      };
    };
    delta = {
      enable = true;
      options = {
        side-by-side = true;
      };
    };

    gpg = {
      enable = true;
      scdaemonSettings = {
        disable-ccid = true;
      };
    };

    zsh = {
      enable = true;
      shellAliases = {
        ls = "lsd";
        cd = "z";
        cat = "bat";
        jjd = "jj diff --git";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "terraform"
          "aws"
        ];
      };
      plugins = [
        {
          name = "powerlevel10k";
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          src = pkgs.zsh-powerlevel10k;
        }
      ];
      initContent = ''
        if [[ -f "$HOME"/.nix-profile/etc/profile.d/nix.sh ]]; then
          source "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi
        if [[ -f "$HOME"/.p10k.zsh ]]; then
          source "$HOME/.p10k.zsh"
        fi
      '';
    };

    ghostty = {
      enable = true;
      settings = {
        window-decoration = false;
        gtk-tabs-location = "bottom";
        gtk-single-instance = true;
        font-family = "CaskaydiaCove Nerd Font Mono";
        font-size = 21;
        theme = "Dracula";
        keybind = [
          "unconsumed:ctrl+tab=unbind"
          "unconsumed:ctrl+shift+tab=unbind"
        ];
      };
    };

    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      prefix = "C-a";
      baseIndex = 1;
      clock24 = true;
      keyMode = "vi";
      shortcut = "a";
      mouse = true;
      terminal = "screen-256color";
      escapeTime = 0;
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = vim-tmux-navigator;
          extraConfig = ''
            set -g @vim_navigator_mapping_left "C-n"
            set -g @vim_navigator_mapping_down "C-e"
            set -g @vim_navigator_mapping_up "C-i"
            set -g @vim_navigator_mapping_right "C-o"
          '';
        }
        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-show-powerline true
            set -g @dracula-show-fahrenheit false
            set -g @dracula-show-location false
          '';
        }
      ];
      extraConfig = ''
        set -ag terminal-overrides ",*:RGB"
        set -g focus-events
        bind C-a last-window
        bind -r N resize-pane -L 6
        bind -r E resize-pane -D 5
        bind -r I resize-pane -U 5
        bind -r O resize-pane -R 5
        bind v split-window -h
        bind s split-window -v
        bind -n C-Tab next-window
        bind -n C-BTab previous-window
        bind C-u copy-mode
        bind -T copy-mode-vi C-v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel
      '';
    };

    firefox = {
      enable = true;
      profiles = {
        me = { };
      };
      nativeMessagingHosts = [ pkgs.web-eid-app ];
    };

    zoxide = {
      enable = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };

    direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
      };
    };

    fzf = {
      enable = true;
      changeDirWidgetOptions = [ "--preview 'tree -C {} | head -200'" ];
      colors = {
        "fg" = "#cbccc6";
        "bg" = "#1f2430";
        "hl" = "#707a8c";
        "fg+" = "#707a8c";
        "bg+" = "#191e2a";
        "hl+" = "#ffcc66";
        "info" = "#73d0ff";
        "prompt" = "#707a8c";
        "pointer" = "#cbccc6";
        "marker" = "#73d0ff";
        "spinner" = "#73d0ff";
        "header" = "#d4bfff";
      };
      fileWidgetOptions = [ "--preview 'head {}'" ];
      historyWidgetOptions = [
        "--sort"
        "--exact"
      ];
    };

    yazi = {
      enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        codecompanion-nvim
        cmp-buffer
        cmp-cmdline
        cmp-path
        cmp-nvim-lsp
        cmp_luasnip
        csvview-nvim
        dracula-nvim
        gitsigns-nvim
        gitsigns-nvim
        hardtime-nvim
        lualine-nvim
        luasnip
        mcphub-nvim.packages."${pkgs.stdenv.hostPlatform.system}".default
        mkdir-nvim
        nvim-autopairs
        nvim-cmp
        nvim-lspconfig
        (nvim-treesitter.withPlugins (p: [
          p.bash
          p.css
          p.dockerfile
          p.elixir
          p.gitcommit
          p.gitignore
          p.gleam
          p.go
          p.hcl
          p.heex
          p.html
          p.hyprlang
          p.javascript
          p.json
          p.lua
          p.mermaid
          p.nix
          p.sql
          p.typescript
          p.yaml
          p.zig
        ]))
        nvim-web-devicons
        plenary-nvim
        tcomment_vim
        telescope-nvim
        telescope-fzf-native-nvim
        vim-fugitive
        vim-repeat
        vim-surround
        vim-test
        vim-tmux-navigator
        vimux
      ];
      extraPackages = with pkgs; [
        bash-language-server
        dockerfile-language-server
        gopls
        gleam
        hyprls
        lua-language-server
        marksman
        nil
        nixfmt-rfc-style
        pyright
        rust-analyzer
        tailwindcss-language-server
        taplo
        terraform-ls
        typescript-language-server
        vscode-langservers-extracted
        yaml-language-server
        zls
      ];
    };

    hyprlock = {
      enable = true;
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        systemd = {
          enable = false;
        };
      };
    };
  };
  xdg = {
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/desktop";
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      music = "${config.home.homeDirectory}/music";
      pictures = "${config.home.homeDirectory}/pictures";
      publicShare = "${config.home.homeDirectory}/public";
      templates = "${config.home.homeDirectory}/templates";
      videos = "${config.home.homeDirectory}/videos";
    };
    configFile = {
      nvim.source = nvim;
      hypr.source = hypr;
      "uwsm" = {
        recursive = true;
        source = ./uwsm;
      };
    };
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  services = {
    gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentry = {
        package = pkgs.pinentry-tty;
      };
    };
    hyprpaper = {
      enable = true;
    };
    hypridle = {
      enable = true;
    };
    hyprpolkitagent = {
      enable = true;
    };
    swaync = {
      enable = true;
    };
  };
}
