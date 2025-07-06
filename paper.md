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

<!-- A summary describing the high-level functionality and purpose of the software -->
<!-- for a diverse, non-specialist audience. -->

Analysis of the entire genome is now part of daily routine in clinical genomics
thanks to technical breakthroughs in DNA sequencing. This results in large
amounts of data that need to be processed by accurate, reproducible, and fast
bioinformatics pipelines. However, achieving reproducibility across different
computing platforms remains challenging. Recent tools have improved this
situation with workflow management systems and consensus reference pipelines.
This work advances the FAIR (Findable, Accessible, Interoperable, Reusable)
principles in clinical bioinformatics by providing a complete reproducible
environment for software dependencies and reference textual databases.

# Statement of need

<!-- A clear statement of need that illustrates the purpose of the software. -->

In bioinformatics, there is a "reproducibility" crisis due to a wide variety of
command-line utilities, possibly with non-deterministic output
[@ziemann_five_2023] and lack of good practices [@baykal_genomic_2024]. While
workflow managers like Nextflow improve pipeline portability
[@di_tommaso_nextflow_2017], and reference pipelines like nf-core/sarek provide
standardized analysis workflows [@ewels_nf-core_2020; @garcia_sarek_2020], reproducibility
across different computing environments remains an issue. Traditional package managers
may not be reproducible across different operating systems and architectures. Similarly,
genomic databases are updated frequently, and current approaches may use outdated
static databases or require manual management of database versions. We offer an alternative
solution for reproducible package and database management for a reference pipeline
in germline genetics.

<!-- A description of how this software compares to other commonly-used packages -->
<!-- in this research area. -->
<!-- Mentions (if applicable) of any ongoing research projects using the software or recent scholarly publications enabled by it. -->

Functional package managers like Nix or Guix allow for fully deterministic
software builds, an approach more robust than containerization.
[@dolstra_nix_2004;@courtes_functional_2013]. Here, we packaged Sarek software
dependencies in Nix for germline analysis and contributed all changes to Nix
central package repository, nixpkgs. Instead of duplicating databases across
servers, like Illumina iGenomes used by Sarek, we offer for the first time a
decentralized approach for data management based on DataLad
@halchenko_datalad_2021. All remote database locations are stored in a single
configuration, allowing for modular access and easier updates. In practice, our
project is completely defined by several configurations, for Nix and Nextflow
execution, and several minimal GitHub repositories to track databases locations.

The project can be used by both researchers and clinical doctors in germline
genetics. This approach cleanly separates package management and database
provisioning from workflow exection in a modular fashion to improve reusability
and reproducibility.

# Acknowledgements

Computations have been performed on the supercomputer facilities of the
Mésocentre de calcul de Franche-Comté (France).

# References
