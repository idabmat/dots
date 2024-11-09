{ pkgs, ... }:

{
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = [
        pkgs.helix-gpt
        pkgs.bash-language-server
        pkgs.dockerfile-language-server-nodejs
        pkgs.elixir-ls
        pkgs.gopls
        pkgs.vscode-langservers-extracted
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
        pkgs.zls
      ];
      languages = {
        "language-server" = {
          gpt = {
            command = "${pkgs.helix-gpt}/bin/helix-gpt";
            args = [ "--handler" "codeium" "--codeiumApiKey" "23028c87-48de-4f33-90bc-3cdad692dd38" ];
          };
        };
        language = [
          {
            name = "hcl";
            formatter = {
              command = "${pkgs.terraform}/bin/terraform";
              args = [ "fmt" "-" ];
            };
          }
          {
            name = "elixir";
            formatter = {
              command = "mix";
              args = [ "format" "-" ];
            };
            "language-servers" = [
              "elixir-ls"
              "gpt"
            ];
          }
          {
            name = "gleam";
            formatter = {
              command = "gleam";
              args = [ "format" "--stdin" ];
            };
          }
          {
            name = "nix";
            formatter = { command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"; };
          }
          {
            name = "tfvars";
            formatter = {
              command = "${pkgs.terraform}/bin/terraform";
              args = [ "fmt" "-" ];
            };
          }
        ];
      };
      settings = {
        theme = "rose_pine_moon";
        editor = {
          true-color = true;
          line-number = "relative";
          cursorline = true;
          cursorcolumn = true;
          color-modes = true;
          soft-wrap = {
            enable = true;
          };
        };
        keys = {
          normal = {
            space = {
              B = ":pipe-to tmux split-window -v helix-git-blame";
            };
          };
        };
      };
    };
  };
}
