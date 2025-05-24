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
            # TODO
            # deepvariant
            dragmap
            fastp
            freebayes
            htslib
            # FIXME
            # manta
            # multiqc # see below
            nextflow
            nf-test # Remove ?
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

          # wait for upstream PR to be merged
          multiqc = pkgs.callPackage ./multiqc { }; 
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
