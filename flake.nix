{
  description = "System configuration";
  inputs = {
    nixpkgs = {
      # Waiting for https://nixpk.gs/pr-tracker.html?pr=488420
      url = "github:NixOS/nixpkgs/160a4c2";
    };
    mcp-hub = {
      url = "github:ravitemer/mcp-hub";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcphub-nvim = {
      url = "github:ravitemer/mcphub.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
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
            specialArgs = inputs // specialArgs;
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
