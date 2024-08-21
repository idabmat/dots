{ pkgs, ... }:

{
  programs = {
    helix = {
      enable = true;
      languages = {
        language-server = {
          elixir-ls = {
            command = "${pkgs.elixir-ls}/bin/elixir-ls";
          };
          terraform-ls = {
            command = "${pkgs.terraform-ls}/bin/terraform-ls";
            args = [ "serve" ];
          };
        };
        language = [
          {
            name = "bash";
          }
          {
            name = "hcl";
            language-servers = [ "terraform-ls" ];
            language-id = "terraform";
            formatter = {
              command = "${pkgs.terraform}/bin/terraform";
              args = [ "fmt" ];
            };
          }
          {
            name = "tfvars";
            language-servers = [ "terraform-ls" ];
            language-id = "terraform-vars";
          }
          {
            name = "elixir";
            formatter = { command = "mix format"; };
          }
          {
            name = "nix";
            formatter = { command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt"; };
          }
        ];
      };
    };
  };
}
