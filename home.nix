{ pkgs, lib, ... }:

{
  imports = [
    ./git.nix
    ./shell.nix
    ./nvim/config.nix
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "graphite-cli"
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
      pkgs.nixpkgs-fmt
      pkgs.nixd
      pkgs.graphite-cli
      pkgs.nodePackages_latest.typescript-language-server
      pkgs.tailwindcss-language-server
      pkgs.yaml-language-server
      pkgs.terraform-ls
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
