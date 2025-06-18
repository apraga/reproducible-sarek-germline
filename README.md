![CI check](https://github.com/apraga/reproducible-sarek-germline/actions/workflows/nix-flake.yml/badge.svg)

This repository offers a reproducible, hassle-free environment to analyze
germline exome or genomic data. In practice, it provides the tools to run
smoothly [nf-core sarek pipeline](https://nf-co.re/sarek/3.4.2/) (germline only)
by

1. install all dependencies with [nix](https://nixos.org/) for reproducibility
2. install datasets needed for variant calling, annotation and filter with
   [datalad](https://www.datalad.org/)

With 2 simple commandes, the pipeline is ready to be run. No need for Docker or
Singularity, or Conda !

## Quickstart

1. Install all dependencies in a shell: `nix develop`
2. Install datasets in the current directory : `cd dgenomes ; datalad get \*`
3. Run sarek. For example, call SNV with `bwa` and `strelka`:

```bash
nextflow run sarek/main.nf --input tests/ada1-e5-e6.csv --outdir bwa-varcall  --tools mpileup,haplotypecaller,freebayes,strelka  -c tests/test.config --skip_tools baserecalibrator,haplotypecaller_filter

```

More information about running sarek
[can be found here](https://nf-co.re/sarek/usage).

## Documentation

### What's available ?

Current version (v0.1) has been tested with:

| Step        | Available                      | Not yet available           |
| ----------- | ------------------------------ | --------------------------- |
| Alignment   | bwa, **bwa-mem2**              | dragmap                     |
| SNV calling | samtools, freebayes, strelka2, |                             |
|             | **haplotypecaller** (\*)       |                             |
| CNV calling |                                | cnvkit                      |
| SV calling  |                                | **tiddit**, manta           |
| Annotation  |                                | **vep**, snpeff, bcftools ? |

Several softwares were already packaged in nixpkgs. In bold, our contribution to
new or existing packages.

### Why should I use this ?

**Reproducibility**. As part of [nf-core](https://nf-co.re) Sarek offers several
ways to install dependencies: Docker, Singularity, Podman, Shifter or
Charliecloud or conda as a "last resort"). While those tools have pros, we
believe a pipeline is more reproducible using [Nix](https://nixos.org). Despite
not being "bit-per-bit" reproducible in some case, it is much stricter than
other tools. For example, a package in Nix is not allowed to download external
dependencies at runtime. Using a simple configuration file called `flake.nix`,
dependencies version are fixed, so every install will have exactly the same
version of the tools.

**No third-party**. Database are downloaded directly from their "producer" so
latest version is easily available for a relevant subset. There are no
dependencies to Illumina, like sarek has. We maintain the versions so you don't
have to. Dependencies and database are not linked to sarek, so this setup can be
used on any relevant pipieline (but nextflow is more supported).

**Tested**. With `datalad`, checksums on datafile allows to detect partial
downloads. Continuos integration ensures all packages build. By defining a small
but clinically relevant test case, SNV calling is checked for "gold standard"
variants on each push.

**Lightweight**. Only configuration files and a small test cases are needed.
Cloning this repository gives you access to a "index" to install package and
download databases.

### Troubleshoot

#### `gzip` : Too many levels of symbolic links

This happens with the FASTA file in genome_human. `gzip -f` works.
