# FAQ

## Can I use on my cluster ?

You need to have nix setup for your cluster. Otherwise,
[see below](./faq.md#can-i-install-dependencies-without-nix). you can install
dependencies through sarek itself and You can still use datalad and
[our approach](/docs/src/tutorial.md#downloading-all-databases) to only download
database. Internet access over https is mandatory though.

## Can I install dependencies without nix ?

Absolutely. You can either let `sarek` install them for you using different
profiles. When running the pipeline, simply add `-profile docker` or
`-profile singularity` for example. See
[nf-core instructions](https://nf-co.re/docs/usage/installation#pipeline-software)
for more information. Or you can install them manually. As long as there are
available on the $PATH, it should work. This is not recommended as it is quite
painful to do and even more so to keep it uptodate.

## Can I use my own databases ?

Yes, you simply need to replace the paths in `nextlow.config` accordingly for
the reference genome, snpeff and vep cache, dbSNP and clinvar.

## What kind of scheduler do you support ?

[Everything supported by nextflow](https://www.nextflow.io/docs/latest/executor.html).

## Can I apply your project to my pipeline ?

Please do ! We aim for modularity so `flake.nix` can be used in any project. It
will make software available in `$PATH`, either in a shell of globally.

## Can you add other software ?

We only support dependencies for sarek (gemline at the moment).

## Do you plan to support Sarek somatic pipeline ?

Not yet but [contributions](./contributing.md) are welcome.

## Could you add support to other nf-core pipeline ?

This is out-of-scope for this repository. But contriubtions to
[nixpkgs](https://github.com/nixos/nixpkgs) are welcome. Don't hesitate to fork
this repository to apply this approach to other pipelines. If this gains enough
traction, we could create an organisation on Github to have all these projects
under the same umbrella.

## Is your project compatible with guix ?

Databases are managed by `datalad`, which is not yet in guix. Other packages are
partially in guix. Don't hesitate to port the nix derivations to Guix !
