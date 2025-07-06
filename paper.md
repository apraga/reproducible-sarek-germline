---
title: Improving nf-core/sarek reproductibility
tags:
  - bioinformatics
  - genetics
  - reproductibility
  - nix
authors:
  - name: Alexis Praga
    orcid: 0000-0002-4540-8371
    corresponding: true # (This is how to denote the corresponding author)
    affiliation: "1" # (Multiple affiliations must be quoted)
  - name: Alexis Overs
    orcid: 0000-0002-0131-9713
    affiliation: 2
  - name: Gaëtan Lepage
    orcid: 0000-0002-5134-7763
    affiliation: 3
affiliations:
  - name:
      Oncobiologie Génétique Bioinformatique,  University Hospital of Besançon,
      France
    index: 1
  - name: Department of Oncobiology, University Hospital of Besançon, France
    index: 2
  - name:
      Grenoble INP Ensimag, HES-SO Valais Wallis, Inria Centre de Recherche
      Grenoble Rhone-Alpes, Université Grenoble Alpes
    index: 3
date: 07 July 2025
bibliography: paper.bib
---

# Summary

Medical genetics have made tremendous advance due to technological breakhtrough
in DNA sequencing. Genome analysis is now part of daily clinical practice. This
has led to an increasing importance of bioinformatics pipelines to filter and
analyze large amount of genetic data. Clinical settings requires accurate,
reproducible and fast results. Such goals have been met for sequencing in
medical laboratories. Unfortunately, much remains to be done for open-source and
reproducible pipeline, especially for germline mutation analysis. Recent
advances in computation reproducibility have been made for workflows management
and for reference pipeline. Here, we propose to push further the FAIR (findable,
accessible, interoperable and reusable) principles by improving the
reproducibility of the reference pipeline for rare diseases, nf-core's sarek ,
for dependencies and database management.

# Statement of need

Computational reproducibility is necessary, but not sufficient, for reliable
results. In bioinformatics research especially, there is a "reproducibility"
crisis for which good practices are beginning to emerge [@baykal_genomic_2024].
Bioniformatics often chain together different tools in a pipeline but the
multiplicity of tools make the creation of a standard pipeline difficult. In
clinical setting for germline genetics, each medical lab will have its own set
of rules based on its expertise. On top of that, some of these tools can have
non-determinist output [@ziemann_five_2023]

To address those issue, we can separate 3 situations: 1. a reproducible
environment where all dependencies are installed, 2. a reproducible execution
and 3. a reproducible validation. Step 3 is laboratory dependent but there are
reference patients than can server a ground truth [@krusche_best_2019]. Step 2
has been improved with workflow manager supporting in a transparent way multiple
schedulers. thanks to tools like Nextflow or Snakemake
[@di_tommaso_nextflow_2017; @koster_snakemake_2012]. From the nextflow community,
several reference pipelines have emerged as part of the nf-core project []@ewels_nf-core_2020].
Sarek is one of theme for germline and somatic analysis [@garcia_sarek_2020].

Step 1. can be partially solved using software packaging tools. nf-core first
choice is bioconda but alternatives like Docker or Singularity are also
possible. To improve reproducibility, functional package managers like Nix TODO
or Guix ensure a determinist output based of a fixed input. When properly
packaged, software shouuld be fully reproducible by avoiding downloading
external data during installation, a behavior found in nextflow by default for
example. Another issue in germline genetics is the importance of external
databases: a reference genome is needed to align short-read data. Also potential
mutation must be annotated with clinically relevant information and protein
prediction. There are some effort to merge those databases to a single place,
like Illumina's iGenomes used by sarek but that makes it harder to use latest
and more relevant versions. To our knowldege, there is no single central hub
where all databases are available in their latest version.

TODO : apport

# Acknowledgements

TODO mésocentre

# References
