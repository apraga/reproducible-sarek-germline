# Context

With the development of Nextflow and the likes (Sarek), it is now much simpler to have a portable pipeline than run with multiple schedulers.
Nf-core is an initiative based on nextflow to offer "reference" pipeline for a given application.
Sarek is one of these pipeline than can analyse germline or somatic data for mutations.
Nf-core pipeline package their dependencies according to multiple strategies (Docker, Singularity, Podman, Shifter, Charliecloud or conda as a "last resort").
Databases management for Sarek is deferred to a central server managed by Illumina, called iGenomes.

We offer another approach where dependencies and databases are managed outside Sarek, using Nix and Datalad. Here are the main pros:

**Reproducibility** For software, containerization is commonly used to offer a portable, closed and reproducible environment. Nix and Guix offer, in our sense, a superior approach to package management. For a given input (software version, checksum of the source code), a package will be build in exactly the same way across multiple architectures. This is possible as Nix stores everything in a special folder, the *store*, and with its graph-based approach to dependencies. A single change in the chain of dependencies will rebuild everything. On top of that, Nix can produce Docker files, allowing for containerization later on.

Databases are managed on Datalad, which is based on git-annex. This allows large files to be managed by git in a Decentralized approach where multiple location can be kept in sync. 
Raw files are not stored, only their "address" (URL, local folder....).

**Decentralized** All packages version are fixed using a simple configuration file called `flake.nix`. Each database is versioned in a git repository, which stores only its location on the web. This means it's lightweight, easily hackable and can be used for other pipelines.

**Up-to-date**. It is easier to keep track of changes in separate repositories. Nixpkgs is an (very) active project and software are often on the latest version. Database are downloaded directly from their "producer". We maintain the versions so you don't
have to. 

**Portable**. Dependencies are simply installed in the PATH. They only require nix to be installed. Even on systems without nix, it's possible to create standalone archives for each software where all dependencies are packed in. Databases are simply symlinks to folder managed by git annex and can be installed anywhere. Finally, this approach is not specific to sarek and used on any relevant pipieline.

**Tested**. With `datalad`, checksums on datafile allows to detect partial
downloads. Continuous integration ensures all packages build. By defining a small
but clinically relevant test case, SNV (single nucleotide variation) and structural variant calling are checked on each change.
