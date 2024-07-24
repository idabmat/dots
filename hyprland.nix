{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];
    settings = {
      monitor = [
        "eDP-1,2560x1600@240,0x0,1"
        "eDP-2,2560x1600@240,0x0,1"
        "DP-3,3840x1100@60,0x1600,1.666667"
        "DP-5,3840x1100@60,0x1600,1.666667"
        "HDMI-A-1,disabled"
      ];
      env = [
        "HYPRLAND_LOG_WLR,1"
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
        "QT_QPA_PLATFORM,wayland"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "HYPRCURSOR_THEME,HyprBibataModernClassicSVG"
        "HYPRCURSOR_SIZE,12"
        "VK_DRIVER_FILES,/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json"
        "LIBVA_DRIVER_NAME,nvidia"
        "GBM_BACKEND,nvidia-drm"
        "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      ];
      exec-once = [
        "wl-paste --watch cliphist store"
        "hyprctl setcursor Bibata-Modern-9a256-v1 12"
        "hyprpaper"
        "hypridle"
        "ags"
      ];
      input = {
        kb_layout = "us,us";
        kb_variant = ",intl";
        kb_options = "grp:ctrl_space_toggle,ctrl:nocaps";
        follow_mouse = 1;
        natural_scroll = "yes";
        touchpad = {
          natural_scroll = "yes";
        };
        sensitivity = 0;
      };
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgba(cc241dee) rgba(fb493466) 90deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "master";
      };
      decoration = {
        rounding = 10;
        drop_shadow = "yes";
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        blur = {
          enabled = "yes";
          size = 3;
          passes = 1;
          new_optimizations = "yes";
        };
      };
      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      misc = {
        disable_hyprland_logo = "true";
        disable_splash_rendering = "true";
        vrr = 2;
      };
      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };
      master = {
        new_status = "master";
      };
      gestures = {
        workspace_swipe = "true";
        workspace_swipe_forever = "true";
      };
      device = [
        {
          name = "elan9009:00-04f3:41d9";
          output = "DP-3";
        }
        {
          name = "elan9009:00-04f3:41d9-1";
          output = "DP-3";
        }
        {
          name = "elan9009:00-04f3:41d9-2";
          output = "DP-3";
        }
        {
          name = "elan9009:00-04f3:41d9-3";
          output = "DP-3";
        }
        {
          name = "elan9009:00-04f3:41d9-4";
          output = "DP-3";
        }
        {
          name = "elan9009:00-04f3:41d9-5";
          output = "DP-3";
        }
      ];
      workspace = [
        "1, monitor:eDP-1, default:true"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "6, monitor:eDP-1"
        "7, monitor:eDP-1"
        "8, monitor:eDP-1"
        "9, monitor:eDP-1"
        "10, monitor:DP-3, default:true"
      ];
      windowrulev2 = [
        "float,title:^(Firefox — Sharing Indicator)$"
        "float,class:^zoom$"
        "float,title:^Extension: "
        "workspace 2,title:^(Firefox)$"
        "workspace 6,title:^(Slack)$"
        "workspace 7,title:^(Discord)$"
        "workspace 8,title:(WhatsApp for Linux)"
        "workspace 9,title:(Spotify)"
      ];
      "$mod" = "SUPER";
      bind = [
        ",XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle"
        ",XF86AudioMicMute,exec,pactl set-source-mute @DEFAULT_SOURCE@ toggle"
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive, "
        "$mod, F, togglefloating, "
        "$mod, space, exec, tofi-drun --prompt-text Run:"
        "$mod, O, exec, /home/me/.nix-profile/bin/2fa"
        "$mod, S, exec, grim"
        "$mod SHIFT, S, exec, grim -g \"$(slurp)\" - | wl-copy"
        "$mod, E, exec, BEMOJI_PICKER_CMD=\"tofi --prompt-text Pick:\" bemoji -n"
        "$mod, V, exec, cliphist list | tofi --prompt Clipboard: | cliphist decode | wl-copy"
        "$mod, Z, resizeactive, exact 1920 1080"
        "$mod, X, fullscreen"
        "$mod, P, exec, loginctl lock-session"
        "$mod, T, togglesplit, "
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"
        "$mod, tab, workspace, e+1"
        "$mod SHIFT, tab, workspace, e-1"
      ];
      binde = [
        ",XF86AudioLowerVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%"
        ",XF86AudioRaiseVolume, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
