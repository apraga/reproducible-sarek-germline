{
  perSystem =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    {
      options = {
        __dependencies = lib.mkOption {
          type = with lib.types; attrsOf package;
          description = ''
            Internal option containing all the dependencies.
          '';
          readOnly = true;
          internal = true;
        };
      };

      config = {
        __dependencies = lib.fix (self: {
          inherit (pkgs)
            bcftools
            bwa
            bwa-mem2
            dragmap
            gatk
            fastp
            fastqc
            freebayes
            htslib
            mosdepth
            multiqc
            nextflow
            samtools
            snpeff
            vep
            vcftools

            # Datalad
            datalad
            git-annex
            ;

          # TODO contribute to nixpkgs
          cnvkit = pkgs.callPackage ./cnvkit { };
          # TODO contribute to nixpkgs
          tiddit = pkgs.callPackage ./tiddit { };

          # Python 2, not supported by nixpkgs
          manta = pkgs.callPackage ./manta { };
          pyflow = pkgs.callPackage ./pyflow { };
          strelka = pkgs.callPackage ./strelka {
            inherit (self) pyflow;
          };
        });

        packages = {
          # Meta package containing all the dependencies
          default = pkgs.buildEnv {
            name = "bundle";
            paths = lib.attrValues config.__dependencies;
          };
        } // config.__dependencies;

        checks = config.packages;
      };
    };
}
