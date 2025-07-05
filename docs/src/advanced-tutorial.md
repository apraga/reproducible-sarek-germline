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

- download only some database

#### update it

To only download a subset, get the corresponding folder. Assuming you cloned
already:

```
datalad get clinvar
```

will only download clinvar.

## Dependencies

[technical details about nix](reference.md#packaging-with-nix)

### Install all dependencies globally

```bash
nix profile install .#*
```

This will make

### use another version of a tools (code + outsied nix)

## Running the pipeline

### Run other tools

### Run other steps

### Running from another folder

The above command use a configuration file `nextflow.config` that is assumed to
be in the current directory. It is perfectly fine to call it from another
location but `-c $GITHUB_ROOT/nextflow.config` must be appended to the
command-line.

By default, What is hidden in this command line More information about running
sarek -[can be found here](https://nf-co.re/sarek/usage).

TODO add user on a cluster (add example configuration to the code)

### Restart from another step

### Set sarek version

### Setting cluster resources

Configuration files are powerful and can be used to define [profiles]().

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

```

```
