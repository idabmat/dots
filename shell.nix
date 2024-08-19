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
}
