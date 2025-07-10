# Advanced tutorials

## Database

### Clean-up space

To avoid duplicating large files, remove at least the initial dbSNP and CADD
files and vep cache::

```bash
cd dbsnp ; git annex drop GCF_000001405.40.gz*
cd cadd ; git annex drop whole_genome_SNVs.tsv.gz*
cd vep-human ; git annex drop homo_sapiens_merged_vep_110_GRCh38.tar.gz
```

### Download only some databases

Simply get the corresponding folder. From dgenomes root directy, download only
clinvar with:

```bash
datalad get clinvar
```

### Update

To keep things up-to-date, synchronize dgenomes: `datalad update --how merge`
Then update the database by going into the corresponding folder and run the same
command.

## Dependencies

### Avoid recompiling dependencies

By default, nix downloads the source code of a package and builds it from
scratch. Nixpkgs has its own binary cache to avoid most of compilation. However,
packages dependent from python 2 are no longer in nixkpgs, due to the lack of
support of python 2. To avoid rebuilding those packages, you can set up a binary
cache [with cachix for example](https://app.cachix.org). This is what the Github
CI does to avoid rebuilding everything. Of course, if there has been a
modification in the package, the binary cache will invalidated and it will be
built from the source code.

### Install all dependencies globally

Instead of having a dedicated shell, you may want to have them available in the
PATH:

```bash
nix profile install .#*
```

### Use another version of a tool

Sometimes, you may want to use a newer or older version. Nix is quite flexible
but it does requires a bit configuration. Basically, creates
`packages/MYPACKAGE/default.nix` following `pyflow` configuration for example.
Then udpate `packages/default.nix` to override the pacakge (again, see how we do
it for pyflow).

## Running the pipeline

### Run other tools

Sarek allow for multiple tools to be used at once. Output of each tools will be
in a different subdirectory. A common use case is to compare variant caller:

```bash
--tools haplotypecaller,strelka

```

### Run other steps

It's possible to start (or restart) for a specific stew with `--step` and a
suitable samplesheet. For example, to annotate directy a vcf:

```bash
--step annotate --tools snpeff
```

And use a samplesheet similar to

```csv
patient,sample,vcf
patient1,test_sample,test.vcf.gz
```

More examples are
[in the official documentation](https://nf-co.re/sarek/3.5.1/docs/usage/).

### Running from another folder

The above command use a configuration file `nextflow.config` that is assumed to
be in the current directory. It is perfectly fine to call it from another
location but `-c $GITHUB_ROOT/nextflow.config` must be appended to the
command-line.

By default, What is hidden in this command line More information about running
sarek -[can be found here](https://nf-co.re/sarek/usage).

TODO add user on a cluster (add example configuration to the code)

### Set sarek version

Add `-r version` on the command-line.

### Setting cluster resources

Usually, each cluster has its own configuration files. The simplest way to start
is to set ressources for processes tagged:

- process_single
- process_low
- process_medium
- process_high

An example is given in `conf/slurm.config` for slurm. Oher executors can of
course be used. It's possible to set resources for
[specificr proesses](https://www.nextflow.io/docs/latest/config.html)

## Troubleshoot

### `gzip` : Too many levels of symbolic links

This happens when extracting the FASTA file in `genome_human`. `gzip -f` is
required for that.
