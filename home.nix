{ config, pkgs, lib, ... }:

{
  imports = [
    ./git.nix
    ./shell.nix
    ./nvim/config.nix
  ];

  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "graphite-cli"
  #   ];
  # nixpkgs.config.joypixels.acceptLicense = true;

  home = {
    username = "me";
    homeDirectory = "/home/me";
    stateVersion = "24.05";
    packages = [
      pkgs.lsd
      pkgs.python3
      pkgs.btop
      pkgs.silver-searcher
      pkgs.ripgrep
      # pkgs.xdg-utils
      # pkgs.libnotify
      # pkgs.inotify-tools
      pkgs.lua-language-server
      pkgs.nixpkgs-fmt
      pkgs.nixd
      # pkgs.graphite-cli
      pkgs.nodePackages_latest.typescript-language-server
      pkgs.tailwindcss-language-server
      pkgs.yaml-language-server
      pkgs.terraform-ls
      # pkgs.vscode-langservers-extracted
      # pkgs.chromium
      # pkgs.chromedriver
    ];
  };

  programs = {
    home-manager = {
      enable = true;
    };
  };
}
