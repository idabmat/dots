{ config, pkgs, lib, ... }:

{
  imports = [
    ./git.nix
    ./shell.nix
    ./helix.nix
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "graphite-cli"
      "terraform"
      "slack"
      "discord"
    ];

  home = {
    username = "me";
    homeDirectory = "/home/me";
    stateVersion = "24.05";
    packages = [
      pkgs.lsd
      pkgs.graphite-cli
      pkgs.python3
      pkgs.btop
      pkgs.ps
      pkgs.silver-searcher
      pkgs.devbox
      pkgs.ripgrep
      pkgs.walker
      pkgs.bitwarden-desktop
      pkgs.yubikey-manager
      pkgs.slack
      pkgs.chromium
      pkgs.discord
      pkgs.wl-clipboard
      pkgs.openrgb
      pkgs.flyctl
      pkgs.rhythmbox
      pkgs.pavucontrol
      (pkgs.writeShellScriptBin "helix-git-blame" ''
        ORIGINAL_PANE=$(tmux select-pane -U)
        PANE_OUTPUT=$(tmux capture-pane -p -t "$ORIGINAL_PANE")
        tmux select-pane -D
        RES=$(echo "$PANE_OUTPUT" | rg -e "(?:NOR|INS|SEL)\s+(\S*)\s[^│]* (\d+):*.*" -o --replace '$1 $2')
        FILE=$(echo "$RES" | cut -d " " -f 1)
        LINE=$(echo "$RES" | cut -d " " -f 2)

        git blame -L "$LINE,+100" "$FILE" --color-by-age --color-lines | 
          fzf --ansi \
              --layout reverse \
              --border \
              --delimiter ':' \
              --height '100%' \
              --multi \
              --print-query --exit-0 \
              --scrollbar '▍' |
              cut -d " " -f 1
      '')
    ];
    file = {
      ".p10k.zsh" = {
        source = ./p10k.zsh;
      };
      ".cache/oh-my-zsh/completions/_devbox" = {
        source = ./_devbox;
      };
      ".cache/oh-my-zsh/completions/_gt" = {
        source = ./_gt;
      };
      ".config/walker/config.json" = {
        source = ./config/walker/config.json;
      };
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };

  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        settings = {
          env = [
            "NIXOS_OZONE_WL,1"
            "LIBVA_DRIVER_NAME,nvidia"
            "GBM_BACKEND,nvidia-drm"
            "__GLX_VENDOR_LIBRARY_NAME,nvidia"
            "NVD_BACKEND,direct"
          ];
          exec-once = [
            "walker --gapplication-service"
          ];
          input = {
            natural_scroll = "yes";
          };
          general = {
            layout = "master";
          };
          master = {
            new_status = "slave";
            orientation = "center";
            always_center_master = true;
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
            "SUPER_SHIFT,1,movetoworkspace,1"
            "SUPER_SHIFT,2,movetoworkspace,2"
            "SUPER_SHIFT,3,movetoworkspace,3"
            "SUPER_SHIFT,4,movetoworkspace,4"
            "SUPER_SHIFT,5,movetoworkspace,5"
            "SUPER_SHIFT,6,movetoworkspace,6"
            "SUPER_SHIFT,7,movetoworkspace,7"
            "SUPER_SHIFT,8,movetoworkspace,8"
            "SUPER_SHIFT,9,movetoworkspace,9"
            "SUPER,tab,workspace,e+1"
            "SUPER_SHIFT,tab,workspace,e-1"
            "SUPER,a,exec,walker -m applications"
            "SUPER,j,exec,walker -m emojis"
            "SUPER,f,togglefloating,"
            "SUPER,q,killactive,"
            "SUPER,s,exec,walker -m websearch"
            "SUPER,v,exec,walker -m clipboard"
            "SUPER,x,fullscreen,"
            "SUPER,return,exec,kitty"
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

  fonts.fontconfig.enable = true;
}
