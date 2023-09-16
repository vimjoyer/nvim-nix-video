{
  description = "My flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-onedark.url = "github:navarasu/onedark.nvim";
    plugin-onedark.flake = false;
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in {

      homeConfigurations."vimjoyer" =
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          modules = [ ./nixos/home.nix ];

          extraSpecialArgs = { inherit inputs; };
        };
    };
}
