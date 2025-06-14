{
  perSystem =
    {
      self',
      lib,
      pkgs,
      ...
    }:
    {
      checks.nextflow-version =
        let
          inherit (self'.packages) nextflow;
        in
        pkgs.runCommand "nextflow-version" { } ''
          # Nextflow needs to write in the user's home directory
          export HOME=$(mktemp -d)

          # Check nextflow runs and outputs the correct version
          ${lib.getExe nextflow} -version | grep "${nextflow.version}"

          # This is a derivation and it must produce an output
          touch $out
        '';
    };
}
