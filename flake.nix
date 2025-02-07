{

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
    };

    description = "Reproducible sarek with Nix and datalad";

    outputs = { self, nixpkgs }:
        let
            system = "x86_64-linux";
            # Unfree is needed for VEP dendencies (kent)
            pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        in {
            packages.${system} = {
                # default = pkgs.callPackage pkgs/nextflow.nix {};
                default = pkgs.nextflow;
                # This install the necessary executables for all nodes
            };
        };
}
