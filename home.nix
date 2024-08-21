{ pkgs, lib, ... }:

{
  imports = [
    ./git.nix
    ./shell.nix
    ./helix.nix
    ./nvim/config.nix
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "graphite-cli"
      "terraform"
    ];
  # nixpkgs.config.joypixels.acceptLicense = true;

  home = {
    username = "me";
    homeDirectory = "/home/me";
    stateVersion = "24.05";
    packages = [
      pkgs.lsd
      pkgs.python3
      pkgs.btop
      pkgs.ps
      pkgs.silver-searcher
      pkgs.ripgrep
      # pkgs.xdg-utils
      # pkgs.libnotify
      pkgs.lua-language-server
      pkgs.nil
      pkgs.graphite-cli
      pkgs.nodePackages_latest.typescript-language-server
      pkgs.tailwindcss-language-server
      pkgs.yaml-language-server
      pkgs.bash-language-server
      # pkgs.vscode-langservers-extracted
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
