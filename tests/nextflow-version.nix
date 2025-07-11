/*
  Simple test that runs `nextflow -version` and checks that the output contains the expected version
  of nextflow.
*/
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
        pkgs.runCommand "nextflow-version"
          {
            nativeBuildInputs = [
              nextflow
            ];
          }
          ''
            # Nextflow needs to write in the user's home directory
            export HOME=$(mktemp -d)

            # Check that nextflow runs and outputs the correct version
            nextflow -version | grep "${nextflow.version}"

            # This is a derivation and it must produce an output
            touch $out
          '';
    };
}
