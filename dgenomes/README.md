References and annotation files for human germline analysis pipeline.

Similar to [iGenomes](https://emea.support.illumina.com/sequencing/sequencing_software/igenome.html) but with [Datalad](https://www.datalad.org/) and (somewhat) more up-to-date data.
Follows the [YODA](https://handbook.datalad.org/en/latest/basics/101-127-yoda.html) principle for reproducible research.

Availabe datasets in GRCh38:
- [x] Clinvar (VCF)
- [x] CADD score
- [x] dbSNP
- [x] Reference genome
- [x] VEP cache

## Disclaimer
- Dataset are not downloaded by default. Use `datalad get` to download them.
- Each dataset is its own git repository and has a license or a reference to it.
- Details about the version or type of database are stored in git log.
- Each major genome version is on a separate branch. Default branch is GRCh38. T2T support is coming soon.
- These are simply mirrors of publicly available data. That means
  - Dataset names are identical to the mirror, unless the name is not descriptive enough.
  For example, genome FASTA is named GCA_000001405.15_GRCh38_full_analysis_set.fna.gz. But
  clinvar is named clinvar_GCRh38.vcf.gz.
  - Some dataset must be decompressed manually
