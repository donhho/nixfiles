{
  description = "System configuration with Nix + Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkHome = extraModules:
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [
            ./home
          ] ++ extraModules;
        };
    in 
    {
      homeConfigurations = {
        don = mkHome [
          ./home/profiles/don
        ];
      };
    };
}
