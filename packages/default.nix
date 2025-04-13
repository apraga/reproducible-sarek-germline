{
  perSystem =
    { pkgs, config, ... }:
    {
      packages = {
        default = pkgs.nextflow;

        inherit (pkgs)
          bcftools
          bwa
          bwa-mem2
          # TODO
          # deepvariant
          dragmap
          freebayes
          # FIXME
          # manta
          multiqc
          samtools
          snpeff
          tiddit
          vep

          # Datalad
          datalad
          git-annex
          ;

        # FIXME pomegranate buid error due to scipy
        #  https://hydra.nixos.org/build/289348001/nixlog/1
        inherit (pkgs.python3Packages) cnvkit;

        strelka = pkgs.callPackage ./strelka { };
      };

      checks = config.packages;
    };
}
