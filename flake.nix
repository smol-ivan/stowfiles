{
  description = "Second nixos approach";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nvf,
      nix-flatpak,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos-smol = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
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
