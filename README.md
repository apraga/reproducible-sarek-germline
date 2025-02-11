This repository enhances [nf-core sarek pipeline](https://nf-co.re/sarek/3.4.2/) (germline only) reproducibility by 
1. install all dependencies with [nix](https://nixos.org/) for bitwise reproducibility
2. install datasets for variant calling, annotation and filter with [datalad](https://www.datalad.org/)

With 3 simple commandes, the pipeline is ready to be run. No need for Docker or Singularity, or Conda !

## Install all dependencies

TODO: nix install + flakes setup + improve command
```
nix flake show --json | jq  '.packages."x86_64-linux"|keys[]' | xargs -I {} nix profile install .#{}
```

## Install datasets

``` bash
datalad clone https://github.com/apraga/dgenomes /WORKDIR/dgenomes
cd /WORKDIR/dgenomes
datalad get *
```

## Available packages

(In bold, new packages added to nix)

- [x] bwa 
- [ ] bwa-mem2 : error
- [ ] *dragmap* : error
- [x] samtools 
- [ ] cnvkit error
- [ ] *deepVariant* : todo
- [x] freebayes 
- [ ] manta : todo
- [ ] strelka2 : error
- [x] tiddit 
- [x] snpeff 
- [ ] *vep* : error
- [x] bcftools 
- [x] *multiqc*
 
