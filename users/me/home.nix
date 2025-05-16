{
  config,
  pkgs,
  lib,
  mcp-hub,
  ...
}:

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
      (callPackage ../../apps/zen.nix { })
      mcp-hub.packages.${pkgs.system}.default
      vulkan-hdr-layer-kwin6
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
      extraLuaConfig = "require('configs/base')";
      plugins = (import ./nvim/plugins.nix { inherit pkgs; });
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
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        systemd = {
          enable = false;
        };
        settings = {
          ecosystem = {
            no_update_news = false;
            no_donation_nag = true;
          };
          experimental = {
            xx_color_management_v4 = false;
          };
          monitor = [
            "eDP-1,2560x1600@180,0x1440,1.25,bitdepth,10,cm,hdr,sdrbrightness,1.2,sdrsaturation,0.98"
            ",preferred,0x0,1,bitdepth,10,cm,hdr,sdrbrightness,1.2,sdrsaturation,0.98"
          ];
          exec-once = [
            "uwsm app -- walker --gapplication-service"
            "uwsm app -- hyprctl setcursor BreezeX-RosePine-Linux 32"
            "uwsm app -- iio-hyprland"
          ];
          input = {
            natural_scroll = "yes";
            touchpad = {
              natural_scroll = "yes";
            };
          };
          dwindle = { };
          master = {
            new_status = "slave";
            orientation = "center";
          };
          general = {
            layout = "dwindle";
            border_size = 1;
            "col.inactive_border" = "0xff1b1c21";
            "col.active_border" = "0xff00ceff 0xff0072ff";
            gaps_out = 0;
          };
          misc = {
            disable_hyprland_logo = true;
            vrr = 2;
          };
          decoration = {
            rounding = 10;
          };
          gestures = {
            workspace_swipe = true;
            workspace_swipe_touch = true;
            workspace_swipe_forever = true;
          };
          device = [
            {
              name = "elan9008:00-04f3:43c7";
              output = "eDP-1";
            }
          ];
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
            # "SUPER,t,exec,ghostty -e ${config.home.homeDirectory}/code/todox/bin/todox"
            "SUPER,f,togglefloating,"
            "SUPER,f,pin,"
            "SUPER,q,killactive,"
            "SUPER,s,exec,grim"
            ''SUPER SHIFT,s,exec,grim -g "$(slurp)" - | wl-copy''
            "SUPER,v,exec,walker -m clipboard"
            "SUPER,x,fullscreen,"
            "SUPER,z,exec,zen"
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
      "uwsm" = {
        recursive = true;
        source = ./uwsm;
      };
      "nvim/lua" = {
        recursive = true;
        source = ./nvim/lua;
      };
      "mcphub/servers.json" = {
        text = builtins.toJSON {
          nativeMCPServers = [ ];
          mcpServers = {
            tidewave = {
              url = "http://localhost:4000/tidewave/mcp";
              disabled = false;
            };
          };
        };
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
        splash = false;
        preload = [ (toString ./wallpaper.jpg) ];
        wallpaper = [ ",${toString ./wallpaper.jpg}" ];
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
