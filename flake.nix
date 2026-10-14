{
  description = "Second nixos approach";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nvf,
      ...
    }@inputs:
    {
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
    };
}
