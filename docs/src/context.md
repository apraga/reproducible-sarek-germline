# Context

**Reproducibility**. As part of [nf-core](https://nf-co.re) Sarek offers several
ways to install dependencies: Docker, Singularity, Podman, Shifter or
Charliecloud or conda as a "last resort"). While those tools have pros, we
believe a pipeline is more reproducible using [Nix](https://nixos.org). Despite
not being "bit-per-bit" reproducible in some case, it is much stricter than
other tools. For example, a package in Nix is not allowed to download external
dependencies at runtime. Using a simple configuration file called `flake.nix`,
dependencies version are fixed, so every install will have exactly the same
version of the tools.

**No third-party**. Database are downloaded directly from their "producer" so
latest version is easily available for a relevant subset. There are no
dependencies to Illumina, like sarek has. We maintain the versions so you don't
have to. Dependencies and database are not linked to sarek, so this setup can be
used on any relevant pipieline (but nextflow is more supported).

**Tested**. With `datalad`, checksums on datafile allows to detect partial
downloads. Continuos integration ensures all packages build. By defining a small
but clinically relevant test case, SNV calling is checked for "gold standard"
variants on each push.

**Lightweight**. Only configuration files and a small test cases are needed.
Cloning this repository gives you access to a "index" to install package and
download databases.
