![CI check](https://github.com/apraga/reproducible-sarek-germline/actions/workflows/nix-flake.yml/badge.svg)

This repository enhances [nf-core sarek pipeline](https://nf-co.re/sarek/3.4.2/) (germline only) reproducibility by
1. install all dependencies with [nix](https://nixos.org/) for bitwise reproducibility
2. install datasets for variant calling, annotation and filter with [datalad](https://www.datalad.org/)

With 3 simple commandes, the pipeline is ready to be run. No need for Docker or Singularity, or Conda !

## Install all dependencies

In a shell :

```
nix develop
```

## Install datasets

To install them on /WORKDIR/dgenomes
<!---
# Not uptodate yet
cd /WORKDIR
datalad install https://datasets.datalad.org/dgenomes
---!>

cd dgenomes
datalad get *
```

## Available packages

(In bold, new packages added to nix or with significant changes)

- [x] bwa
- [x] bwa-mem2
- [x] *dragmap*
- [x] samtools
- [ ] cnvkit : some method may be wrong
- [ ] *deepVariant* : todo
- [x] freebayes
- [ ] manta : todo
- [x] *strelka2* (local, due to python2)
- [x] tiddit
- [x] snpeff
- [x] *vep*
- [x] bcftools
- [x] *multiqc*

## Troubleshoot
### `gzip` : Too many levels of symbolic links
This happens with the FASTA file in genome_human. `gzip -f` works.