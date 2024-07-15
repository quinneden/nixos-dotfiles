{
  description = "Your new nix config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.follows.nixpkgs = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-apple-silicon,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "aarch64-linux";
    dotdir = "$HOME/.dotfiles";
  in {
    formatter = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations = {
      macmini = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs dotdir;};
        modules = [
          ./system/core.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs outputs dotdir;};
              backupFileExtension = "backup";
              users = {
                quinn = import ./home;
              };
            };
          }
        ];
      };
    };
  };
}
