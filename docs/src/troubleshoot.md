# Troubleshoot

## CRAM version 3.1 is not supported by GATK HaplotypeCaller

An upgrade to htslib (1.22) means samtools output CRAM in 3.1 format, not yet supported by GATK (4.6.2).
We fixed that in the flake by downgrading htslib. If you install from the flake, it should not happen.

## `gzip` : Too many levels of symbolic links

This happens when extracting the FASTA file in `genome_human`. `gzip -f` is
required for that.
