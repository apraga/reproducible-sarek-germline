{

  inputs = {
    # Fix nixpkgs version
    nixpkgs.url = "github:NixOS/nixpkgs/8b4774acdcb580100877eeb59d2a9eca4380ffb1";
    # nixpkgs.url = "nixpkgs/nixos-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  description = "Reproducible sarek with Nix and datalad";

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
      ];

      imports = [
        ./dev.nix
        ./packages
        ./shell.nix
      ];

      perSystem =
        {
          config,
          lib,
          system,
          pkgs,
          ...
        }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              # For manta
              permittedInsecurePackages = [
                "python-2.7.18.8"
                "python-2.7.18.8-env"
              ];
            };
          };
        };
    };
}
