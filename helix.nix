{ pkgs, ... }:

{
  programs = {
    helix = {
      enable = true;
      languages = {
        language-server = {
          bash-language-server = {
            command = "${pkgs.bash-language-server}/bin/bash-language-server";
          };
          # css = {
          #   command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
          # };
          docker-langserver = {
            command = "${pkgs.dockerfile-language-server-nodejs}";
          };
          elixir-ls = {
            command = "${pkgs.elixir-ls}/bin/elixir-ls";
            config = {
              elixirLS.dialyzerEnabled = true;
            };
          };
          gopls = {
            command = "${pkgs.gopls}/bin/gopls";
          };
          # html = {
          #   command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
          # };
          # json = {
          #   command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
          # };
          # jsonc = {
          #   command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
          # };
          lua-language-server = {
            command = "${pkgs.lua-language-server}/bin/lua-language-server";
          };
          marksman = {
            command = "${pkgs.marksman}/bin/marksman";
          };
          nil = {
            command = "${pkgs.nil}/bin/nil";
          };
          rust-analyzer = {
            command = "${pkgs.rust-analyzer}/bin/rust-analyzer";
          };
          # scss = {
          #   command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
          # };
          slint-lsp = {
            command = "${pkgs.slint-lsp}/bin/slint-lsp";
          };
          solargraph = {
            command = "${pkgs.rubyPackages.solargraph}/bin/solargraph";
          };
          tailwindcss-ls = {
            command = "${pkgs.tailwindcss-language-server}/bin/tailwindcss-language-server";
          };
          taplo = {
            command = "${pkgs.taplo}/bin/taplo";
          };
          terraform-ls = {
            command = "${pkgs.terraform-ls}/bin/terraform-ls";
          };
          typescript-language-server = {
            command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
          };
          yaml-language-server = {
            command = "${pkgs.yaml-language-server}/bin/yaml-language-server";
          };
        };
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
