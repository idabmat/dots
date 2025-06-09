{
  config,
  pkgs,
  lib,
  mcp-hub,
  mcphub-nvim,
  ...
}:

let
  hypr = config.lib.file.mkOutOfStoreSymlink /home/me/.config/home-manager/users/me/hypr;
  nvim = config.lib.file.mkOutOfStoreSymlink /home/me/.config/home-manager/users/me/nvim;
  naya-flow = import ../../apps/naya-flow.nix { inherit pkgs; };
in
{
  home = {
    username = "me";
    homeDirectory = "/home/me";
    stateVersion = "24.11";
    packages = with pkgs; [
      fastfetch
      lsd
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
      ayu-theme-gtk
      rose-pine-cursor
      beauty-line-icon-theme
      kdePackages.qtwayland
      kdePackages.qt6ct
      kdePackages.qtstyleplugin-kvantum
      gradience
      nwg-look
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
      mcp-hub.packages.${pkgs.system}.default
      vulkan-hdr-layer-kwin6
      sshuttle
      docker-compose
      kooha
      naya-flow
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

  dconf = {
    enable = true;
  };

  programs = {
    home-manager = {
      enable = true;
    };
    git = {
      enable = true;
      userName = "Igor de Alcantara Barroso";
      userEmail = "igor@talimhq.com";
      signing = {
        key = "794A41BA3DBE9931";
        signByDefault = true;
      };
      delta = {
        enable = true;
        options = {
          side-by-side = true;
        };
      };
      extraConfig = {
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
        theme = "ayu";
        keybind = [
          "ctrl+a>shift+r=reload_config"

          "ctrl+a>c=new_tab"
          "ctrl+a>n=next_tab"
          "ctrl+tab=next_tab"
          "ctrl+a>n=previous_tab"
          "ctrl+shift+tab=previous_tab"

          "ctrl+a>one=goto_tab:1"
          "ctrl+a>two=goto_tab:2"
          "ctrl+a>three=goto_tab:3"
          "ctrl+a>four=goto_tab:4"
          "ctrl+a>five=goto_tab:5"
          "ctrl+a>six=goto_tab:6"
          "ctrl+a>seven=goto_tab:7"
          "ctrl+a>eight=goto_tab:8"
          "ctrl+a>nine=goto_tab:9"

          "ctrl+a>s=new_split:down"
          "ctrl+a>v=new_split:right"
          "ctrl+a>left=goto_split:left"
          "ctrl+a>right=goto_split:right"
          "ctrl+a>ctrl+a=goto_split:next"
          "shift+up=scroll_page_up"
          "shift+down=scroll_page_down"
        ];
      };
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
        theme = "rose-pine";
      };
      themes = {
        rose-pine = {
          src = pkgs.fetchFromGitHub {
            owner = "rose-pine";
            repo = "tm-theme";
            rev = "c4235f9a65fd180ac0f5e4396e3a86e21a0884ec";
            hash = "sha256-jji8WOKDkzAq8K+uSZAziMULI8Kh7e96cBRimGvIYKY=";
          };
          file = "dist/themes/rose-pine-moon.tmTheme";
        };
      };
    };

    direnv = {
      enable = true;
    };

    fzf = {
      enable = true;
      colors = {
        fg = "#908caa";
        bg = "#232136";
        hl = "#ea9a97";
        "fg+" = "#e0def4";
        "bg+" = "#393552";
        "hl+" = "#ea9a97";
        border = "#44415a";
        header = "#3e8fb0";
        gutter = "#232136";
        spinner = "#f6c177";
        info = "#9ccfd8";
        pointer = "#c4a7e7";
        marker = "#eb6f92";
        prompt = "#908caa";
      };
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
        gitsigns-nvim
        gitsigns-nvim
        hardtime-nvim
        lualine-nvim
        luasnip
        mcphub-nvim.packages."${pkgs.system}".default
        mkdir-nvim
        neotest
        neotest-elixir
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
        neovim-ayu
        tcomment_vim
        telescope-nvim
        telescope-fzf-native-nvim
        vim-fugitive
        vim-repeat
        vim-surround
      ];
      extraPackages = with pkgs; [
        bash-language-server
        dockerfile-language-server-nodejs
        elixir-ls
        gopls
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
      hypr.source = hypr;
      nvim.source = nvim;
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
