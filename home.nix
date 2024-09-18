{ pkgs, lib, ... }:

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
    };
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
