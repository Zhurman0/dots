{
    description = "Alpine Home Manager setup";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
    in {
        homeConfigurations."hurma" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            modules = [
                ./home.nix
            ];
        };
    };
}
