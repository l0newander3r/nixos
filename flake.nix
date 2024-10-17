{
  description = "Lone Wanderers NixOS modules";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lf-icons = {
      url = "github:gokcehan/lf";
      flake = false;
    };

    snowfall = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.home-manager.follows = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall.mkFlake {
      inherit inputs;

      src = ./.;

      alias = {
        modules.nixos.default = "all";
        modules.darwin.default = "all";
        modules.home.default = "all";
      };

      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [];
        config = {};
      };

      outputs-builder = channels: {
        formatter = channels.nixpkgs.alejandra;
      };

      snowfall = {
        namespace = "lonewanderer";

        meta = {
          name = "lonewanderer";
          title = "Lone Wanderer";
        };
      };
    };
}
