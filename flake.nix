{

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  description = "Reproducible sarek with Nix and datalad";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      # Unfree is needed for VEP dendencies (kent)
      pkgs = import nixpkgs {
        inherit system;
        config = {
          permittedInsecurePackages = [
            # For manta
            "python-2.7.18.8"
          ];
          allowUnfree = true;
        };
      };

    in {
      packages.${system} = {
        default = pkgs.nextflow;
        bwa = pkgs.bwa;
        # FIXME
        bwa-mem2 = pkgs.bwa-mem2;
        # FIXME
        dragmap = pkgs.dragmap;
        samtools = pkgs.samtools;
        # FIXME python 2
        cnvkit = pkgs.pythonPackages.cnvkit;
        # TODO
        # deepVariant = pkgs.deepvariant;
        freebayes = pkgs.freebayes;
        manta = pkgs.manta;
        # FIXME python 2
        strelka2 = pkgs.strelka;
        tiddit = pkgs.tiddit;
        snpeff = pkgs.snpeff;
        # wait for PR
        # vep = pkgs.vep;
        bcftools = pkgs.bcftools;
        multiqc = pkgs.multiqc;
        # Datalad
        datalad = pkgs.datalad;
        git-annex = pkgs.git-annex;
      };
    };
}
