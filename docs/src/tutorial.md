# Tutorials

This tutorial will show you how to configure everything needed to run the sarek
pipeline (germline only) and how to use the pipeline for analysis. The only
requirement is [to install nix](https://nixos.org/download/#download-nix).

## Installing all dependencies

First, enable nix flakes:

```bash
cat 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

```

Then, setup with `nix` a nice hell with everything installed. From the code
source directory, run:

```bash
nix develop
```

_All the commands below should be typed in this shell_. It's also possible to
use
[a global installation](./advanced-tutorial.md#install-all-dependencies-globally).

Technical details are developed further [here](./reference.md#dependencies).

## Downloading all databases

This is managed by `datalad`. In the following, we assume there are stored in
`/Work/data/dgenomes`. To download all of them at once:

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
tar xzf  genome-human -C genome-human/*.tar.gz
gunzip genome-human/*.gz
tar xzf  vep-human -C vep-human/*.tar.gz
unzip snpeff-human/*.zip -d snpeff-human
# Rename chromosomes for Refseq to chr1,chr2...
cd dbsnp ; bash rename_chr.sh
# Rename chromosomes for 1,2, to chr1,chr2.... Take around 7 hours !
cd cadd ; bash rename_chr.sh
```

Don't forget [to cleanup large files](./advanced-tutorial.md#clean-up-space) if
needed. See also
[the advanced tutorial for databases](./advanced-tutorial.md#database) and the
[technical details](./reference.md#databases).

## Running the pipeline

A run is defined by a CSV files where the samples and input files are defined
(_samplesheet_). Here's on for a single, minimal, sample to start from a FASTQ

```csv
patient,sex,status,sample,lane,fastq_1,fastq_2
test,XX,0,test,ada2-e5-e6,tests/ada2-e5-e6_R1.fastq.gz,tests/ada2-e5-e6_R2.fastq.gz
```

Additional samples can be added to the CSV and nextflow will run as many jobs as
needed. See
[the official docs](https://nf-co.re/sarek/usage#overview-samplesheet-columns)
for more information.

Running the pipeline from alignment with `bwa` up to variant calling with GATK
is done **from the root of github repo** with:

```bash
 nextflow run nf-core/sarek \
 --input tests/ada2-e5-e6.csv --outdir test-datalad-full \
 --tools haplotypecaller,snpeff --skip_tools haplotypecaller_filter \
 --dgenomes /Work/dgenomes
```

Several things are happening here so let us examine each argument:

- `nextflow run nf-core/sarek` will download the latest version of `sarek`
  online and run it.
  [You can set sarek version](./advanced-tutorial.md#set-sarek-version) for more
  reproductibility.
- `--input` define the samplesheet
- `--output` define the output directory where the result of each step will be
  stored in a subfolder. If multiple samples are analyzed, each subfolder will
  have the result of all samples.
- `--tools` define the step to run and which tool to use. `bwa` is used by
  default for alignement. Here, `haplotypecaller` is set for variant calling.
  Sarek filter with GATK
  [FilterVariantTranches](https://gatk.broadinstitute.org/hc/en-us/articles/360040098912-FilterVariantTranches)
  by default but GATK `CNNScoreVariant` has not been packaged by nix yet
- `--dgenomes` **must** be set to **full path** the root folder of the databases
  (see [above](#downloading-all-databases) by default, assumes a
  `nextflow.config` in the current directory. This files setups some tools for
  nix and is mandatory. See
  [here](./advanced-tutorial.md#running-from-another-folder) to run from another
  location.

### Running on a cluster

This command will run the pipeline as a normal process. Nextflow supports
[many schedulers](https://www.nextflow.io/docs/latest/executor.html). A simple
configuration file can be used to select a scheduler Here, a profile for slurm
is available in the `conf` directory. To use it, simply append to the command
line `-c conf/slurm.conf`. To customize it, see
[here](advanced-tutorial.md#setting-cluster-resources).
