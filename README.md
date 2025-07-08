![Builds](https://github.com/apraga/reproducible-sarek-germline/actions/workflows/nix-flake.yml/badge.svg)
![Variant calling](https://github.com/apraga/reproducible-sarek-germline/actions/workflows/variant-calling.yml/badge.svg)
![Annotation](https://github.com/apraga/reproducible-sarek-germline/actions/workflows/annotation.yml/badge.svg)

This repository offers a reproducible, hassle-free environment to analyze
germline exome or genomic data. In practice, it provides the tools to run
smoothly [nf-core sarek pipeline](https://nf-co.re/sarek/3.4.2/) (germline only)
by

1. install all dependencies with [nix](https://nixos.org/) for reproducibility
2. install datasets needed for variant calling, annotation and filter with
   [datalad](https://www.datalad.org/)

With 3 steps, the pipeline is ready to be run. No need for Docker or
Singularity, or Conda !

## Quickstart

1. Install all dependencies in a shell: `nix develop`
2. Install datasets in the current directory :
   `datalad clone https://github.com/apraga/dgenomes  ; cd dgenomes ; datalad get genome-human ; gunzip genome-human/GCA*.fna.gz ; tar xzf genome-human/*.tar.gz -C genome-human`
3. Call SNV with `bwa` and `strelka` on a minimal example with:

```bash
nextflow run sarek/main.nf --input tests/ada1-e5-e6.csv --outdir bwa-varcall  --tools mpileup,haplotypecaller,freebayes,strelka  -c tests/test.config --skip_tools baserecalibrator,haplotypecaller_filter

```

More information about
[can be found here](https://alexis.praga.dev/reproducible-sarek-germline/tutorial).

## Documentation

### What's available ?

Current version (v0.1) has been tested with:

| Step        | Available                                              |
| ----------- | ------------------------------------------------------ |
| Alignment   | bwa, **bwa-mem2**, **dragmap**                         |
| SNV calling | samtools, freebayes, **strelka2**, **haplotypecaller** |
| CNV calling | cnvkit                                                 |
| SV calling  | **tiddit**, **manta**                                  |
| Annotation  | **vep**, **snpeff**, bcftools ?                        |

Several softwares were already packaged in nixpkgs. In bold, our contribution to
new or existing packages.

### Why should I use this ?

We follow Unix philosophy to combine several tools, where each tool does one
thing very well. Here, Sarek managed the pipeline execution. Instead of using
containers to install package and a single server to download database, those
are delegated to nix and datalad.

This ensures **reproduciblity**, the **absence of third-parties** and a
**decentralized** appreach to follow FAIR principles. Continous integration on
Github ensure variant calling gives accurate result for a small test case. It's
**ligthweight** as only a set of configuration files are needed. Finally, it's
extremely **customizable**.

[See the context for more information](https://alexis.praga.dev/reproducible-sarek-germline/cntext).
