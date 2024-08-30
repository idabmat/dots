{ pkgs, ... }:

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
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.bat = {
    enable = true;
    config = {
      theme = "gruvbox-dark";
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
    terminal = "screen-256color";
    escapeTime = 0;
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
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
}
