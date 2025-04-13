{
  lib,
  fetchFromGitHub,
  python2Packages,
}:

python2Packages.buildPythonPackage rec {
  pname = "pyflow";
  version = "0-unstable-2020-07-10";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "illumina";
    repo = "pyflow";
    rev = "7ac42ee33faabe6cedc10dce989d7516dcce3cec";
    hash = "sha256-dCtYfuv+VbmidvQxooEdf0HmkOyJahLfCA3WYadkjVM=";
  };

  sourceRoot = "${src.name}/pyflow";

  build-system = [ python2Packages.setuptools ];

  # No test as it requires read/write permissions on the source dir
  doCheck = false;

  meta = {
    description = "Python library that makes color math, color scales, and color-space conversion easy";
    homepage = "https://github.com/jsvine/spectra";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ apraga ];
  };
}
