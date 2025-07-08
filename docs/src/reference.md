# Reference

## Architecture

- data :
  - how it works (explain git annex + dgenomes)
  - where is it ("producer")
  - how is it updated
- packaging
  - flake
- software version :
  - tests

## Limits

- CI does not test nextflow packaged by nix
- not CNN
- data : ?

- Contributing

## Tests

Minimal testing :

- SNV calling for 2 variants TODO
- Annotation with snpeff : we check no variants were lost after annotation and
  there is an annotation field
- Defered to the nix package
  - CNVkit : does not work well for SV < 1Mb (TODO lin) : t
    [CNVkit is less accurate in detecting CNVs smaller than 1 Mbp, typically only detecting variants that span multiple exons or captured regions. When used on exome or target panel datasets,](https://cnvkit.readthedocs.io/en/stable/germline.html)
  - vep: cache is too large for github ci !

## Dependencies

summary of nix derivation and hash.

Reminder of nix architecture. Explain the difference betweet nix shell and
gloabl install

TODO

- python2 -> local version everything has been contributed back to nix

- cnnnscore
- nextflow

### Conflict between strelka and dragmap

Strelka and dragmap install files with the same name in /lib/python, /libexec
and /boot/grub/As a workaround, strelka installation directory has a subfolder
strelka containing everything except bin. Path has been fixed for that.

## Databases

## Running the pipeline

### Nextfolw configuration files

explain why it's neede
