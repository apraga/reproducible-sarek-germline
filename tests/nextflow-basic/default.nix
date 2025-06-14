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
        pkgs.runCommand "nextflow-basic"
          {
            nativeBuildInputs = [
              self'.packages.nextflow
            ];
          }
          ''
            # Nextflow needs to write in the user's home directory
            export HOME=$(mktemp -d)

            mkdir $out

            nextflow run \
              ./sarek/main.nf \
              --input tests/chl1-exon13.csv \
              --outdir $out/chl1-exon13 \
              --tools haplotypecaller \
              --skip_tools haplotypecaller_filter \
              --process.cpus $NIX_BUILD_CORES
          '';
    };
}
