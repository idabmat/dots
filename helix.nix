{ pkgs, ... }:

{
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = [
        pkgs.bash-language-server
        pkgs.dockerfile-language-server-nodejs
        pkgs.elixir-ls
        pkgs.gopls
        # pkgs.vscode-langservers-extracted
        pkgs.lua-language-server
        pkgs.marksman
        pkgs.nil
        pkgs.rust-analyzer
        pkgs.slint-lsp
        pkgs.rubyPackages.solargraph
        pkgs.tailwindcss-language-server
        pkgs.taplo
        pkgs.terraform-ls
        pkgs.typescript-language-server
        pkgs.yaml-language-server
      ];
      languages = {
        language = [
          {
            name = "hcl";
            formatter = {
              command = "${pkgs.terraform}/bin/terraform";
              args = [ "fmt" ];
            };
          }
          {
            name = "elixir";
            formatter = { command = "mix format"; };
          }
          {
            name = "nix";
            formatter = { command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"; };
          }
          {
            name = "tfvars";
            formatter = {
              command = "${pkgs.terraform}/bin/terraform";
              args = [ "fmt" ];
            };
          }
        ];
      };
      settings = {
        theme = "gruvbox_dark_hard";
        editor = {
          true-color = true;
        };
      };
    };
  };
}
