{
  config,
  pkgs,
  lib,
  hyprland,
  hyprgrass,
  expert,
  ...
}:
let
  defaultFont = "Inter";
  liveDir = dir: config.lib.file.mkOutOfStoreSymlink "/home/me/.config/home-manager/users/me/${dir}";
  yazi-theme = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "yazi";
    rev = "main";
    sha256 = "sha256-9e3dXViWl1rK9BPrGAFfs9ZL/tsG6Njz6ksuU6AIrFY=";
  };
  lsd-theme = pkgs.fetchFromGitHub {
    owner = "nolight132";
    repo = "rose-pine-lsd";
    rev = "main";
    sha256 = "sha256-Vbzt2aSnyGZZ42gUNmPWVvewjZQ88U3k15xxXxofcNM=";
  };
  rose-pine-icons = pkgs.fetchFromGitHub {
    owner = "Henriquehnnm";
    repo = "rose-pine-icon-theme";
    rev = "main";
    sha256 = "sha256-/CGj07sgM4kGQVRSW//tyYrRzh5puPTONLxWPNzeZNM=";
  };
in
{
  home = {
    username = "me";
    homeDirectory = "/home/me";
    stateVersion = "24.11";
    shell = {
      enableZshIntegration = true;
    };
    packages = with pkgs; [
      ps
      unzip
      yubikey-manager
      yubioath-flutter
      slack
      wl-clipboard
      cliphist
      bemoji
      mplayer
      imv
      gimp
      pavucontrol
      brightnessctl
      playerctl
      rose-pine-cursor
      kdePackages.qtwayland
      kdePackages.qt6ct
      adw-gtk3
      adwaita-icon-theme
      inter
      nerd-fonts.caskaydia-cove
      nautilus
      slurp
      grim
      kooha
      swaynotificationcenter
      bluetui
      keymapp
      iio-hyprland
      wvkbd
      nwg-drawer
      amp-cli
      hyprgrass.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    pointerCursor = {
      enable = true;
      gtk = {
        enable = true;
      };
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 32;
    };
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine";
    };
    colorScheme = "dark";

    iconTheme = {
      name = "RoséPine";
    };

    font = {
      name = defaultFont;
    };

    gtk3 = {
      extraConfig = {
        gtk-application-prefer-dark-theme = true;
      };
    };
    gtk4 = {
      theme = config.gtk.theme;
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
        app_launcher_cmd = "nwg-drawer";
        appearance = {
          scale_factor = 1.5;
          style = "Solid";
          text_color = "#e0def4";
          font_name = defaultFont;
          background_color = {
            base = "#191724";
            weak = "#1f1d2e";
            strong = "#26233a";
          };
          primary_color = "#c4a7e7";
          secondary_color = "#403d52";
          success_color = "#9ccfd8";
          danger_color = "#eb6f92";
        };
        region = "en_IE";
        modules = {
          left = [ "Workspaces" ];
          center = [ "Tempo" ];
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
    fastfetch = {
      enable = true;
    };
    ripgrep = {
      enable = true;
      arguments = [
        "--smart-case"
      ];
    };
    lsd = {
      enable = true;
      colors = "${lsd-theme}/colors.yaml";
    };
    jq = {
      enable = true;
    };
    discord = {
      enable = true;
      settings = {
        BACKGROUND_COLOR = "#000000";
        chromiumSwitches = { };
        IS_MAXIMIZED = true;
        IS_MINIMIZED = false;
        offloadAdmControls = true;
        enableHardwareAcceleration = true;
        openH264Enabled = true;
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
          default-command = "log";
          diff-formatter = ":git";
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
        format = "openpgp";
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
        ag = "rg";
        cd = "z";
        cat = "bat";
        jjd = "jj diff";
        tree = "lsd --tree";
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
          src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
          file = "powerlevel10k.zsh-theme";
        }
      ];
      initContent = lib.mkOrder 1000 ''
        source ${./p10k.zsh}
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
        theme = "Rose Pine";
        background-opacity = 0.9;
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
          plugin = rose-pine;
          extraConfig = ''
            set -g @rose_pine_variant 'main'
          '';
        }
      ];
      extraConfig = ''
        set -ag terminal-overrides ",*:RGB"
        set -g focus-events
        set -s extended-keys on
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
      configPath = "${config.xdg.configHome}/mozilla/firefox";
      profiles = {
        me = { };
      };
      policies = {
        DisableAppUpdate = true;
        DisableFirefoxStudies = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        FirefoxHome = {
          SponsoredStories = false;
          SponsoredTopSites = false;
          Stories = false;
        };
        GenerativeAI = {
          Enabled = false;
        };
        SearchEngines = {
          Remove = [ "Perplexity" ];
        };
      };
      nativeMessagingHosts = [ pkgs.web-eid-app ];
    };
    chromium = {
      enable = true;
      commandLineArgs = [
        "--force-device-scale-factor=1.6"
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
      ];
      dictionaries = [
        pkgs.hunspellDictsChromium.en-gb
        pkgs.hunspellDictsChromium.fr-fr
      ];
      extensions = [
        { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # ublock
        { id = "nngceckbapebfimnlniiiahkandclblb"; } # bitwarden
        { id = "ncibgoaomkmdpilpocfeponihegamlic"; } # web eid
        { id = "bkdgflcldnnnapblkhphbgpggdiikppg"; } # duckduckgo
      ];
      nativeMessagingHosts = [ pkgs.web-eid-app ];
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "TTY";
        base_10_sizes = true;
      };
    };
    zoxide = {
      enable = true;
    };
    bat = {
      enable = true;
      themes = {
        rose-pine = {
          src = yazi-theme;
          file = "flavors/rose-pine.yazi/tmtheme.xml";
        };
      };
      config = {
        theme = "rose-pine";
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
      colors = {
        "fg" = "#908caa";
        "bg" = "#191724";
        "hl" = "#ebbcba";
        "fg+" = "#e0def4";
        "bg+" = "#26233a";
        "hl+" = "#ebbcba";
        "border" = "#403d52";
        "header" = "#31748f";
        "gutter" = "#191724";
        "spinner" = "#f6c177";
        "info" = "#9ccfd8";
        "pointer" = "#c4a7e7";
        "marker" = "#eb6f92";
        "prompt" = "#908caa";
      };
      changeDirWidget = {
        options = [ "--preview 'lsd --tree -C {} | head -200'" ];
      };
      fileWidget = {
        options = [ "--preview 'head {}'" ];
      };
      historyWidget = {
        options = [
          "--sort"
          "--exact"
        ];
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withRuby = false;
      withPython3 = false;
      initLua = ''
        vim.opt.rtp:prepend(vim.fn.expand("~/.config/my-nvim"))
        dofile(vim.fn.expand("~/.config/my-nvim/init.lua"))
      '';
      plugins = with pkgs.vimPlugins; [
        amp-nvim
        codecompanion-nvim
        cmp-buffer
        cmp-cmdline
        cmp-path
        cmp-nvim-lsp
        cmp_luasnip
        csvview-nvim
        rose-pine
        gitsigns-nvim
        gitsigns-nvim
        hardtime-nvim
        hunk-nvim
        lualine-nvim
        luasnip
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
          p.markdown_inline
          p.mermaid
          p.nix
          p.sql
          p.typescript
          p.yaml
          p.zig
        ]))
        nvim-web-devicons
        plenary-nvim
        render-markdown-nvim
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
        expert.packages.${pkgs.stdenv.hostPlatform.system}.default
        beamMinimal28Packages.rebar3
        gopls
        gleam
        hyprls
        lua-language-server
        marksman
        nil
        nixfmt
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
    mcp = {
      enable = true;
      servers = {
        tidewave = {
          url = "http://localhost:4000/tidewave/mcp";
          custom_instructions = {
            text = ''
              This is a Phoenix application, which uses Tailwind.
              Prefer using LiveView instead of regular Controllers.
              Once you are done with changes, run `mix compile` and fix any issues.
              Write tests for your changes and run `mix test` afterwards.
            '';
          };
        };
        linear = {
          url = "https://mcp.linear.app/mcp";
          headers = {
            Authorization = "Bearer {env:LINEAR_API_KEY}";
          };
        };
      };
    };
    claude-code = {
      enable = true;
      enableMcpIntegration = false;
    };
    opencode = {
      enable = true;
      enableMcpIntegration = true;
      tui = {
        theme = "rose-pine";
      };
      settings = {
        provider = {
          "llama.cpp" = {
            npm = "@ai-sdk/openai-compatible";
            name = "llama.cpp (local)";
            options = {
              baseURL = "http://127.0.0.1:8080/v1";
            };
            models = {
              "qwen3.5-35b-a3b" = {
                name = "Qwen3.5 35B-A3B (local)";
                limit = {
                  context = 131072;
                  output = 65536;
                };
              };
            };
          };
        };
      };
    };
    hyprlock = {
      enable = true;
    };
    zathura = {
      enable = true;
      options = {
        # source: https://github.com/edunfelt/zathura/blob/main/rose-pine
        default-bg = "#191724";
        default-fg = "#e0def4";
        statusbar-fg = "#e0def4";
        statusbar-bg = "#555169";
        inputbar-bg = "#6e6a86";
        inputbar-fg = "#ebbcba";
        notification-bg = "#e0def4";
        notification-fg = "#555169";
        notification-error-bg = "#f6c177";
        notification-error-fg = "#555169";
        notification-warning-bg = "#ebbcba";
        notification-warning-fg = "#555169";
        highlight-color = "rgba(0xeb, 0xbc, 0xba, 0.5)";
        highlight-active-color = "rgba(0xeb, 0x6f, 0x92, 0.5)";
        completion-bg = "#6e6a86";
        completion-fg = "#ebbcba";
        completion-highlight-fg = "#26233a";
        completion-highlight-bg = "#ebbcba";
        recolor-lightcolor = "#191724";
        recolor-darkcolor = "#e0def4";
        recolor = "false";
        recolor-keephue = "false";
      };
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        configType = "lua";
        package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        systemd = {
          enable = false;
        };
      };
    };
  };

  home.activation.hyprLuarc = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run install -Dm644 /dev/stdin /home/me/.config/home-manager/users/me/hypr/.luarc.json <<EOF
    ${builtins.toJSON {
      workspace.library = [
        "${config.wayland.windowManager.hyprland.finalPackage}/share/hypr/stubs"
      ];
      diagnostics.globals = [ "hl" ];
    }}
    EOF
  '';

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
      setSessionVariables = true;
    };
    configFile = {
      hypr.source = liveDir "hypr";
      my-nvim.source = liveDir "nvim";
      nwg-drawer.source = liveDir "nwg-drawer";
      uwsm.source = liveDir "uwsm";
      "hypr/.luarc.json".enable = lib.mkForce false;
    };
    dataFile = {
      "icons/RoséPine".source = "${rose-pine-icons}/icons/RoséPine";
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
    hyprlauncher = {
      enable = true;
    };
    swaync = {
      enable = true;
    };
  };
}
