{
  perSystem =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {

        # Add all the packages declared in ./packages/default.nix to the shell environment.
        buildInputs = lib.attrValues config.packages;
      };
    };
}
