{
  config,
  pkgs,
  lib,
  mcp-hub,
  mcphub-nvim,
  ...
}:

let
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
      wvkbd
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
      settings = {
        background = [
          {
            path = "${./wallpaper.jpg}";
          }
        ];

        general = {
          disable_loading_bar = false;
          grace = 0;
          no_fade_in = false;
        };

        input-field = [
          {
            monitor = "";
            size = "320, 55";
            dots_center = true;
            dots_size = 0.2;
            dots_spacing = 0.2;
            fade_on_empty = false;
            font_color = "rgb(200, 200, 200)";
            halign = "left";
            hide_input = false;
            inner_color = "rgba(255, 255, 255, 0)";
            outer_color = "rgba(255, 255, 255, 0)";
            outline_thickness = 0;
            placeholder_text = ''🔒 <i><span foreground="##ffffff99">Enter password</span></i>'';
            position = "160, -30";
            valign = "center";
          }
        ];

        label = [
          {
            monitor = "";
            color = "rgba(216, 222, 233, .85)";
            font_size = 40;
            halign = "left";
            position = "240, 110";
            text = ''cmd[update:1000] echo "<span>$(date +"%H:%M")</span>"'';
            valign = "center";
          }
          {
            monitor = "";
            color = "rgba(216, 222, 233, .85)";
            font_size = 20;
            halign = "left";
            position = "217, 040";
            text = ''cmd[update:1000] echo -e "$(date +"%A, %B %d")"'';
            valign = "center";
          }
        ];
      };
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        systemd = {
          enable = false;
        };
        settings = {
          decoration = {
            rounding = 10;
          };

          device = [
            {
              name = "elan9008:00-04f3:43c7";
              output = "eDP-1";
            }
            {
              name = "elan9008:00-04f3:43c7-stylus";
              output = "eDP-1";
            }
          ];
          ecosystem = {
            no_donation_nag = true;
            no_update_news = false;
          };
          experimental = {
            xx_color_management_v4 = false;
          };
          general = {
            border_size = 1;
            "col.active_border" = "0xff00ceff 0xff0072ff";
            "col.inactive_border" = "0xff1b1c21";
            gaps_out = 0;
            layout = "dwindle";
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_forever = true;
            workspace_swipe_touch = true;
          };
          input = {
            touchpad = {
              natural_scroll = "yes";
            };
            natural_scroll = "yes";
          };
          master = {
            new_status = "slave";
            orientation = "center";
          };
          misc = {
            disable_hyprland_logo = true;
            vrr = 2;
          };
          bind = [
            "SUPER,n,movefocus,l"
            "SUPER,e,movefocus,d"
            "SUPER,i,movefocus,u"
            "SUPER,o,movefocus,r"
            "SUPER_SHIFT,n,movewindow,l"
            "SUPER_SHIFT,e,movewindow,d"
            "SUPER_SHIFT,i,movewindow,u"
            "SUPER_SHIFT,o,movewindow,r"
            "SUPER,1,workspace,1"
            "SUPER,2,workspace,2"
            "SUPER,3,workspace,3"
            "SUPER,4,workspace,4"
            "SUPER,5,workspace,5"
            "SUPER,6,workspace,6"
            "SUPER,7,workspace,7"
            "SUPER,8,workspace,8"
            "SUPER,9,workspace,9"
            "SUPER,0,workspace,10"
            "SUPER_SHIFT,1,movetoworkspace,1"
            "SUPER_SHIFT,2,movetoworkspace,2"
            "SUPER_SHIFT,3,movetoworkspace,3"
            "SUPER_SHIFT,4,movetoworkspace,4"
            "SUPER_SHIFT,5,movetoworkspace,5"
            "SUPER_SHIFT,6,movetoworkspace,6"
            "SUPER_SHIFT,7,movetoworkspace,7"
            "SUPER_SHIFT,8,movetoworkspace,8"
            "SUPER_SHIFT,9,movetoworkspace,9"
            "SUPER_SHIFT,0,movetoworkspace,10"
            "SUPER,tab,workspace,m+1"
            "SUPER_SHIFT,tab,workspace,m-1"
            "SUPER,a,exec,walker -m applications"
            "SUPER,d,exec,walker -m websearch"
            "SUPER,j,exec,walker -m emojis"
            "SUPER,f,togglefloating,"
            "SUPER,f,pin,"
            "SUPER,l,exec,hyprlock"
            "SUPER,q,killactive,"
            "SUPER,s,exec,grim"
            ''SUPER SHIFT,s,exec,grim -g "$(slurp)" - | wl-copy''
            "SUPER,v,exec,walker -m clipboard"
            "SUPER,x,fullscreen,"
            "SUPER,z,exec,firefox"
            "SUPER,return,exec,ghostty"
            "SUPER,space,exec,swaync-client -t"
          ];
          binde = [
            "SUPER CTRL,n,exec,hyprctl dispatch resizeactive -10 0"
            "SUPER CTRL,e,exec,hyprctl dispatch resizeactive 0 -10"
            "SUPER CTRL,i,exec,hyprctl dispatch resizeactive 0 10"
            "SUPER CTRL,o,exec,hyprctl dispatch resizeactive 10 0"
          ];
          bindel = [
            ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ];
          bindl = [
            ",XF86AudioMute,exec,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute,exec,wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            ",XF86AudioPlay,exec,playerctl play-pause"
            ",XF86AudioPrev,exec,playerctl previous"
            ",XF86AudioNext,exec,playerctl next"
            ",XF86AudioStop,exec,playerctl stop"
          ];
          bindm = [
            "CTRL,mouse:272,movewindow"
            "CTRL,mouse:273,resizewindow"
          ];
          exec-once = [
            "uwsm app -- walker --gapplication-service"
            "uwsm app -- hyprctl setcursor BreezeX-RosePine-Linux 32"
            "uwsm app -- iio-hyprland"
            "uwsm app -- wvkbd-mobintl -H 350 -L 300 --hidden"
          ];
          monitor = [
            "eDP-1,2560x1600@180,0x0,1"
            ",preferred,0x1600,1"
          ];
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
      settings = {
        ipc = "on";
        preload = [ "${./wallpaper.jpg}" ];
        splash = false;
        wallpaper = [ ",${./wallpaper.jpg}" ];
      };
    };
    hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          before_sleep_cmd = "loginctl lock-session";
          lock_cmd = "pidof hyprlock || hyprlock";
        };

        listener = [
          {
            on-resume = "brightnessctl -r";
            on-timeout = "brightnessctl -s set 10";
            timeout = 60;
          }
          {
            on-timeout = "loginctl lock-session";
            timeout = 180;
          }
          {
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
            on-timeout = "hyprctl dispatch dpms off";
            timeout = 180;
          }
          {
            on-timeout = "systemctl suspend";
            timeout = 600;
          }
        ];
      };
    };
    hyprpolkitagent = {
      enable = true;
    };
    swaync = {
      enable = true;
    };
  };
}
