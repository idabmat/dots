{ config, pkgs, lib, ... }:

let
  zen-browser = pkgs.stdenv.mkDerivation {
    name = "zen-browser";
    src = pkgs.fetchurl {
      url = "https://github.com/zen-browser/desktop/releases/download/1.11.4b/zen-x86_64.AppImage";
      sha256 = "03rpmrxzvj9r2gmv7v3lw70d3n107xadcjg0jqyw72cp8gjsn76c";
    };
    buildInputs = with pkgs; [ appimage-run makeWrapper ];
    buildCommand = ''
      mkdir -p $out/bin $out/share/applications
      cp $src $out/share/applications/zen-browser.AppImage
      chmod +x $out/share/applications/zen-browser.AppImage
      makeWrapper ${pkgs.appimage-run}/bin/appimage-run $out/bin/zen-browser --add-flags "$out/share/applications/zen-browser.AppImage"
    '';
  };
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "me";
    homeDirectory = "/home/me";
    stateVersion = "24.05";
    packages = [
      pkgs.lsd
      pkgs.lla
      pkgs.graphite-cli
      pkgs.python3
      pkgs.exercism
      pkgs.btop
      pkgs.ps
      pkgs.unzip
      pkgs.silver-searcher
      pkgs.devbox
      pkgs.ripgrep
      pkgs.walker
      pkgs.bitwarden-desktop
      pkgs.yubikey-manager
      pkgs.yubioath-flutter
      pkgs.slack
      pkgs.chromium
      pkgs.discord
      pkgs.wl-clipboard
      pkgs.openrgb
      pkgs.flyctl
      pkgs.gnome-podcasts
      pkgs.gnome-music
      pkgs.mplayer
      pkgs.timg
      pkgs.localsearch
      pkgs.pavucontrol
      pkgs.playerctl
      pkgs.code-cursor
      pkgs.rose-pine-cursor
      pkgs.rose-pine-gtk-theme
      pkgs.rose-pine-icon-theme
      pkgs.gradience
      pkgs.nwg-look
      pkgs.adw-gtk3
      pkgs.adwaita-icon-theme
      pkgs.nautilus
      pkgs.aichat
      pkgs.yek
      pkgs.jq
      pkgs.cantarell-fonts
      pkgs.slurp
      pkgs.grim
      pkgs.motion
      pkgs.gimp
      pkgs.jellyfin
      pkgs.audiobookshelf
      pkgs.libation
      pkgs.swaynotificationcenter
      pkgs.spotify
      zen-browser
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
        ${pkgs.lla}/bin/lla completion zsh --path ${config.home.homeDirectory}/.cache/oh-my-zsh/completions/_lla
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
      initExtra = ''
        if [[ -f "$HOME"/.nix-profile/etc/profile.d/nix.sh ]]; then
          source "$HOME/.nix-profile/etc/profile.d/nix.sh"
        fi
        if [[ -f "$HOME"/.p10k.zsh ]]; then
          source "$HOME/.p10k.zsh"
        fi
      '';
    };

    kitty = {
      enable = true;
      font = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font Mono";
        size = 14;
      };
      settings = {
        disable_ligatures = "cursor";
        background_opacity = 1.0;
      };
      shellIntegration = {
        enableZshIntegration = true;
      };
      themeFile = "rose-pine";
    };

    ghostty = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        window-decoration = false;
        gtk-tabs-location = "bottom";
        gtk-single-instance = true;
        font-family = "CaskaydiaCove Nerd Font Mono";
        font-size = 21;
        theme = "rose-pine-moon";
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
        ];
      };
    };

    firefox = {
      enable = true;
      profiles = {
        me = { };
      };
      nativeMessagingHosts = [
        pkgs.web-eid-app
      ];
    };

    beets = {
      enable = false;
      settings = {
        directory = "/media/music";
        plugins = [
          "fetchart"
        ];
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
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
      enableZshIntegration = true;
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
      terminal = "xterm-256color";
      escapeTime = 0;
      newSession = true;
      plugins = [
        pkgs.tmuxPlugins.vim-tmux-navigator
        {
          plugin = pkgs.tmuxPlugins.rose-pine;
          extraConfig = "set -g @rose_pine_variant 'moon'";
        }
      ];
      extraConfig = ''
        set -ag terminal-overrides ",*:RGB"
        bind C-a last-window
        bind -r H resize-pane -L 5
        bind -r J resize-pane -D 5
        bind -r K resize-pane -U 5
        bind -r L resize-pane -R 5
        bind C-u copy-mode
        bind -T copy-mode-vi C-v send-keys -X begin-selection
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel
      '';
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
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
      enableZshIntegration = true;
    };

    helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = [
        pkgs.helix-gpt
        pkgs.bash-language-server
        pkgs.dockerfile-language-server-nodejs
        pkgs.elixir-ls
        pkgs.gopls
        pkgs.vscode-langservers-extracted
        pkgs.lua-language-server
        pkgs.marksman
        pkgs.nil
        pkgs.rust-analyzer
        pkgs.slint-lsp
        pkgs.rubyPackages.solargraph
        pkgs.tailwindcss-language-server
        pkgs.taplo
        pkgs.terraform-ls
        pkgs.typescript-language-server
        pkgs.yaml-language-server
        pkgs.zls
      ];
      languages = {
        "language-server" = {
          gpt = {
            command = "${pkgs.helix-gpt}/bin/helix-gpt";
            args = [ "--handler" "ollama" "--ollamaModel" "qwen2.5-coder" ];
          };
        };
        language = [
          {
            name = "hcl";
            formatter = {
              command = "${pkgs.terraform}/bin/terraform";
              args = [ "fmt" "-" ];
            };
          }
          {
            name = "elixir";
            formatter = {
              command = "mix";
              args = [ "format" "-" ];
            };
            "language-servers" = [
              "elixir-ls"
              "gpt"
            ];
          }
          {
            name = "go";
            "language-servers" = [
              "gopls"
              "gpt"
            ];
          }
          {
            name = "gleam";
            formatter = {
              command = "gleam";
              args = [ "format" "--stdin" ];
            };
          }
          {
            name = "nix";
            formatter = { command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"; };
          }
          {
            name = "tfvars";
            formatter = {
              command = "${pkgs.terraform}/bin/terraform";
              args = [ "fmt" "-" ];
            };
          }
        ];
      };
      settings = {
        theme = "rose_pine_moon";
        editor = {
          true-color = true;
          cursorline = true;
          cursorcolumn = true;
          color-modes = true;
          soft-wrap = {
            enable = true;
          };
          default-yank-register = "+";
          clipboard-provider = "wayland";
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "warning";
          };
        };
      };
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        systemd = {
          variables = [ "--all" ];
        };
        settings = {
          monitor = [
            "DP-1,3440x1440@143.92, 0x0, 1"
          ];
          env = [
            "NIXOS_OZONE_WL,1"
            "LIBVA_DRIVER_NAME,nvidia"
            "GBM_BACKEND,nvidia-drm"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            "NVD_BACKEND,direct"
            "XCURSOR_SIZE,32"
            "HYPRCURSOR_THEME,BreezeX-RosePine-Linux"
            "HYPRCURSOR_SIZE,32"
            "FREETYPE_PROPERTIES,cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"
            "GDK_DPI_SCALE,1.5"
          ];
          exec-once = [
            "walker --gapplication-service"
            "hyprctl setcursor BreezeX-RosePine-Linux 32"
            "swaync"
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
            "col.inactive_border" = "0xff6e6a86";
            "col.active_border" = "0xff9ccfd8";
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
            workspace_swipe = "true";
            workspace_swipe_forever = "true";
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
            "SUPER,t,exec,ghostty -e ${config.home.homeDirectory}/code/todox/bin/todox"
            "SUPER,f,togglefloating,"
            "SUPER,q,killactive,"
            "SUPER,s,exec,grim"
            "SUPER SHIFT,s,exec,grim -g \"$(slurp)\" - | wl-copy"
            "SUPER,v,exec,walker -m clipboard"
            "SUPER,x,fullscreen,"
            "SUPER,z,exec,zen-browser"
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
      pinentryPackage = pkgs.pinentry-tty;
    };
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        preload = [ "${config.home.homeDirectory}/.config/home-manager/wallpaper.png" ];
        wallpaper = [ ",${config.home.homeDirectory}/.config/home-manager/wallpaper.png" ];
      };
    };
  };
}
