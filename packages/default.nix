{
  perSystem =
    { pkgs, config, ... }:
    {
      packages = {

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

        pyflow = pkgs.callPackage ./pyflow { };
        strelka = pkgs.callPackage ./strelka {
          inherit (config.packages) pyflow;
        };

        default = pkgs.buildEnv {
          name = "reproducible-sarek";
          paths = with pkgs ; [
            bwa
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

            strelka
            
          ] ;
        };
      };

      checks = config.packages;
    };
}
