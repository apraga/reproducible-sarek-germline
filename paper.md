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

Analysis of the entirety of the genome is now part of daily routine in clinical
genomics thanks to technical breakthroughs in DNA sequencing. This results in
large amounts of data that need to be processed by accurate, reproducible and
fast bioinformatics pipelines. However achieving reproducibility across
different computing platforms remains challenging. Recent tools have improved
upon this situation with workflow management systems and consensus reference
pipelines. This work advances the FAIR (Findable, Accessible, Interoperable,
Reusable) principles in clinical bioinformatics by providing a complete
reproducible environment for software dependencies and functional databases.

# Statement of need

<!-- A clear statement of need that illustrates the purpose of the software. -->

In bioinformatics, there is a "reproducibility" crisis due to a a wide variety
of command-line utilities, possibly with non-determinist output
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

Functional package manager like Nix or Guix allow for fully determistic software
builds, an approach more robust than containerisation.
[@dolstra_nix_2004;@courtes_functional_2013]. Here, we packaged in Nix Sarek
software dependencies for germline analysis and contributed all changes to nix
central package repository, nixpkgs. Instead of duplicating databases across
servers, like Illumina iGenomes used by Sarek, we offer for the first time a
decentralized approach for data management based on Datalad
@halchenko_datalad_2021. All remote database locations are stored in a single
configuration, allowing for modular accessand easier updates.

This approach builds upon the strengths of the Sarek pipeline with a modular
approach to package management and database provisioning, making it suitable for
deployment in both research and clinical environments.

# Acknowledgements

Computations have been performed on the supercomputer facilities of the
Mésocentre de calcul de Franche-Comté (France).

# References
