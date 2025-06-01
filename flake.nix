{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      myUsername = "fowlron";
      system = "x86_64-linux";

      specialArgsForHost = hostName: {
        inherit inputs myUsername;
        host = hostName;
      };

      specialArgsForHome = hostName: {
        inherit inputs myUsername;
        host = hostName;
      };
    in
  {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = specialArgsForHost "desktop";
        modules = [
          ./hosts/common.nix
          ./hosts/desktop/default.nix

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true; # Use system nixpkgs for Home Manager
            home-manager.useUserPackages = true; # Allow home manager to install packages
            home-manager.extraSpecialArgs = specialArgsForHome "desktop";
            home-manager.backupFileExtension = "hm-bak";
            home-manager.users.${myUsername} = import ./homemanager/common.nix;
          }
        ];
      };
    };
  };
}
