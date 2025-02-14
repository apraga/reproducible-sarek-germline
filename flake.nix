{

  inputs = {
# Fix nixpkgs version
    nixpkgs.url = "github:NixOS/nixpkgs/7b75c7a591aa1425d5feefa38dc3151b05d17dad";
    # nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  description = "Reproducible sarek with Nix and datalad";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      # Unfree is needed for VEP dendencies (kent)
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
      # For manta
          permittedInsecurePackages = [
            "python-2.7.18.8"
          ];
      };
    };

    in {
      packages.${system} = {
        default = pkgs.nextflow;
        bwa = pkgs.bwa;
        bwa-mem2 = pkgs.bwa-mem2;
        dragmap = pkgs.dragmap;
        samtools = pkgs.samtools;
        # FIXME pomegranate buid error due to scipy
        #  https://hydra.nixos.org/build/289348001/nixlog/1
        cnvkit = pkgs.python3Packages.cnvkit;
        # TODO
        # deepVariant = pkgs.deepvariant;
        freebayes = pkgs.freebayes;
        manta = pkgs.manta;
        # FIXME
        strelka2 = pkgs.strelka;
        tiddit = pkgs.tiddit;
        snpeff = pkgs.snpeff;
        vep = pkgs.vep;
        bcftools = pkgs.bcftools;
        multiqc = pkgs.multiqc;
        # Datalad
        datalad = pkgs.datalad;
        git-annex = pkgs.git-annex;
      };
    };
}
