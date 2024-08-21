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
      pkgs.ripgrep
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
