{
  description = "System configuration";
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    mcp-hub.url = "github:ravitemer/mcp-hub";
    mcphub-nvim.url = "github:ravitemer/mcphub.nvim";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
  };
  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        nixtab =
          let
            users = {
              "me" = ./users/me/home.nix;
            };
            specialArgs = { inherit users; };
          in
          nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = specialArgs;
            modules = [
              ./hosts/nixtab
              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  extraSpecialArgs = inputs // specialArgs;
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users = users;
                };
              }
            ];
          };
      };
    };
}
