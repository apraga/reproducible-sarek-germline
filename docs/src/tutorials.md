# Tutorials

This tutorial will show you how to configure everything needed to run the sarek
pipeline (germline only) and how to use the pipeline for analysis.

**Installing all dependencies** `nix` setup for us a shell with everything
installed. From the code source directory, run:

```bash
nix develop
```

_All the commands below should be typed in the shell_.

**Downloading all databases** This is managed by `datalad`. In the following, we
assume there are stored in `/Work/data/dgenomes`. To download all of them at
once:

```bash
cd /Work/data
git clone https://github.com/apraga/dgenomes
cd dgenomes
datalad get .
```

Unfortunately, some data are not pipeline-ready. Especially, dbSNP and CADD use
a different chromosome notation and must be renamed. For CADD, it takes around 7
hours ! Note the version numbers must be corrected to match the current version.

```bash
# Extract bwa index
cd genome-human
tar xzvf GCA_000001405.15_GRCh38_full_analysis_set.fna.bwa_index.tar.gz
# Extract vep cache
cd vep-human
tar xvzf  homo_sapiens_merged_vep_110_GRCh38.tar.gz
# Extract snpeff cache
cd snpeff
unzip snpEff_v4_3_GRCh38.86.zip
# Rename chromosomes for Refseq to chr1,chr2...
cd dbsnp
bash rename_chr.sh
# Rename chromosomes for 1,2, to chr1,chr2.... Take around 7 hours !
cd cadd
bash rename_chr.sh
```

Don't forget [to cleanup large files](#clean-up-space) if needed

**Running the pipeline** A run is defined by a CSV files where the samples and
input files are defined (_samplesheet_). Here's on for a single, minimal, sample
to start from a FASTQ

````csv
patient,sex,status,sample,lane,fastq_1,fastq_2
test,XX,0,test,ada2-e5-e6,tests/ada2-e5-e6_R1.fastq.gz,tests/ada2-e5-e6_R2.fastq.gz
+```

Multiple samples can be added. To align with `bwa` and call variant with GATK:

 ### chose the tools (SNVs calling)

 TODO

 params.dgenomes = location of dgenomes. Must be overrider as it requires a
 **full path**

 path to clinvar must be update manually in nextflow.config

-More information about running sarek
-[can be found here](https://nf-co.re/sarek/usage).
-
-### Run
-
 ```bash
 nextflow run nf-core/sarek --input tests/ada2-e5-e6.csv --outdir
 test-datalad-full -c nextflow.config --tools haplotypecaller,vep --skip_tools
 haplotypecaller_filter
````

+More information about running
sarek +[can be found here](https://nf-co.re/sarek/usage).

- TODO expliquer qu'on skippe cnnscore et que ça utilise la version distante de
  sarek (mais moins reproductible) TODO comment fixer la version de sarek

  TODO add user on a cluster (add example configuration to the code)

  ## Advanced tutorial

### Database

#### Clean-up space

To avoid duplicating large files, remove at least the initial dbSNP and CADD
files and vep cache::

```bash
cd dbsnp
git annex drop GCF_000001405.40.gz*
cd cadd
git annex drop whole_genome_SNVs.tsv.gz*
cd vep-human
 git annex drop homo_sapiens_merged_vep_110_GRCh38.tar.gz
```

TODO

- Install dependencies globally
- download only some database

[technical details about nix](reference.md#packaging-with-nix)

#### update it

To only download a subset, get the corresponding folder. Assuming you cloned
already:

```
datalad get clinvar
```

will only download clinvar.

### To install all dependencies globally

```bash
nix profile install .#*
```

### use another version of a tools (code + outsied nix)

## Troubleshoot

### `gzip` : Too many levels of symbolic links

This happens with the FASTA file in genome_human. `gzip -f` works.

## My cluster do not have internet access

Not supported.

## FAQ

**Can I install dependencies without nix ?** Absolutely. You can either let
`sarek` install them for you using different profiles. When running the
pipeline, simply add `-profile docker` or `-profile singularity` for example.
See
[nf-core instructions](https://nf-co.re/docs/usage/installation#pipeline-software)
for more information. Or you can install them manually. As long as there are
available on the $PATH, it should work. This is not recommended as it is quite
painful to do and even more so to keep it uptodate.
