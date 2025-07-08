# FAQ

### Can I use on my cluster ?

You need to have nix setup for your cluster. Otherwise,
[see below](./faq.md#can-i-install-dependencies-without-nix). you can install
dependencies through sarek itself and You can still use datalad and
[our approach](/docs/src/tutorial.md#downloading-all-databases) to only download
database. Internet access over https is mandatory though.

### Can I install dependencies without nix ?

Absolutely. You can either let `sarek` install them for you using different
profiles. When running the pipeline, simply add `-profile docker` or
`-profile singularity` for example. See
[nf-core instructions](https://nf-co.re/docs/usage/installation#pipeline-software)
for more information. Or you can install them manually. As long as there are
available on the $PATH, it should work. This is not recommended as it is quite
painful to do and even more so to keep it uptodate.

### Can I use my own databases ?

Yes, you simply need to replace the paths in `nextlow.config` accordingly for
the reference genome, snpeff and vep cache, dbSNP and clinvar.

### What kind of environment do you support ?

[Everything supported by nextflow](https://www.nextflow.io/docs/latest/executor.html).
