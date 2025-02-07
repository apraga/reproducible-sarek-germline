## Depedencies
```bash
nix profile install nixpkgs#datalad
nix profile install nixpkgs#git-annex
```

## Install databases
```
datalad clone https://github.com/apraga/dgenomes /WORKDIR/dgenomes
cd /WORKDIR/dgenomes
datalad get *
```
Wait a while..

## TODO
- [ ] flakes
