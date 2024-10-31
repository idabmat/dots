{ config, pkgs, ... }:

{
  programs.zsh = {
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
  programs.kitty = {
    enable = true;
    font = {
      package = (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; });
      name = "CaskaydiaCove Nerd Font Mono";
      size = 14;
    };
    settings = {
      disable_ligatures = "cursor";
      background_opacity = 0.5;
    };
    shellIntegration = {
      enableZshIntegration = true;
    };
    themeFile = "rose-pine-moon";
  };
  programs.firefox = {
    enable = true;
  };
  programs.beets = {
    enable = true;
    settings = {
      directory = "${config.home.homeDirectory}/music";
      plugins = [
      ];
    };
  };
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "rose-pine-moon";
    };
    themes = {
      rose-pine-moon = {
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
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.tmux = {
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
  programs.fzf = {
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
}
