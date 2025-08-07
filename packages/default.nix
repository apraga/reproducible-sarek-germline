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
            tiddit
            vep
            vcftools

            # Datalad
            datalad
            git-annex
            ;

          # Downgrade htslib 1.21 to avoid samtools to output files in CRAM 3.1
          # GATK haplotyecaller does not support that. This means samtools must
          # also be downgraded
          samtools =
            (pkgs.samtools.override {
              htslib = pkgs.callPackage ./htslib { };
            }).overrideAttrs
              (old: rec {
                version = "1.21";
                src = pkgs.fetchurl {
                  url = "https://github.com/samtools/samtools/releases/download/${version}/samtools-${version}.tar.bz2";
                  sha256 = "sha256-BXJLCDprbwMF/K5SQ6BWzDbPgmMJw8uTR6a4nuP8Wto=";
                };
              });

          # TODO contribute to nixpkgs
          snpeff = pkgs.callPackage ./snpeff { };

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
        }
        // config.__dependencies;

        checks = config.packages;
      };
    };
}
