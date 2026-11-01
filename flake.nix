{
  description = "NixOS and nix-darwin macOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    {
      nixpkgs,
      nix-darwin,
      home-manager,
      nvf,
      ...
    }@inputs:
    {
      # Configuración de NixOS existente
      nixosConfigurations.nixos-smol = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";

              extraSpecialArgs = { inherit inputs; };

              users.chattini = {
                imports = [
                  ./home.nix
                  inputs.nvf.homeManagerModules.default
                ];
              };
            };
          }
        ];
      };

      # Configuración de nix-darwin para macOS
      darwinConfigurations."MacBook-Air-de-Ivan" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin-configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; };

              users.cherry = {
                imports = [
                  ./darwin-home.nix
                  nvf.homeManagerModules.default
                ];
              };
            };
          }
        ];
      };
    };
}
