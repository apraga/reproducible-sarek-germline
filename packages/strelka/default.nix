{

  lib,
  stdenv,
  fetchFromGitHub,
  htslib,

  # nativeBuildInputs
  cmake,

  # buildInputs
  boost,
  curl,
  zlib,
  python2,
  pyflow,

  rapidjson,
}:

let
  pythonEnv = python2.withPackages (ps: [ pyflow ]);
in
stdenv.mkDerivation (finalAttrs: {
  pname = "strelka";
  version = "2.9.10";

  src = fetchFromGitHub {
    owner = "Illumina";
    repo = "strelka";
    tag = "v${finalAttrs.version}";
    hash = "sha256-7l4CmW8vUJ3sVS1PdbzQY8nXkdUZZisE7ESEUGNd09s=";
  };

  patches = [
    # Only codemin and bgzf_extra are shipped with strelk as there are not available
    # elsewhere
    ./no-vendoring.patch
    ./std-numeric.patch
  ];

  postPatch = ''
    # Use nix boost
    substituteInPlace src/cmake/boost.cmake \
      --replace-fail "1.58.0" "${boost.version}" \
      --replace-fail "Boost_USE_STATIC_LIBS ON" "Boost_USE_STATIC_LIBS OFF"

    # template-id not allowed for constructor in C++20
    substituteInPlace src/c++/lib/blt_util/stringer.hh \
      --replace-fail "stringer<T>()" "stringer()"

    # Replace executable with nix. bgzip9 and bgzf_cat are vendored
    substituteInPlace src/python/lib/strelkaSharedOptions.py \
      --replace-fail 'bgzipBin=joinFile(libexecDir,exeFile("bgzip"))' \
                     'bgzipBin=exeFile("${lib.getExe' htslib "bgzip"}")' \
      --replace-fail 'htsfileBin=joinFile(libexecDir,exeFile("htsfile"))' \
                     'htsfileBin=exeFile("${lib.getExe' htslib "htsfile"}")' \
      --replace-fail 'samtoolsBin=joinFile(libexecDir,exeFile("samtools"))' \
                     'samtoolsBin=exeFile("${lib.getExe' htslib "samtools"}")' \
      --replace-fail 'tabixBin=joinFile(libexecDir,exeFile("tabix"))' \
                     'tabixBin=exeFile("${lib.getExe' htslib "tabix"}")'

    for f in src/python/bin/*.py; do
      substituteInPlace $f \
        --replace-fail '/usr/bin/env python2' ${python2.interpreter}
    done

    # Strelka generates files with env, use nix instead
    substituteInPlace src/python/lib/makeRunScript.py \
      --replace-fail "/usr/bin/env python2" "${python2.interpreter}"

    # Update sys.path.append with our pyflow
    for f in strelkaSequenceErrorEstimation.py strelkaGermlineWorkflow.py snoiseWorkflow.py sequenceAlleleCountsWorkflow.py ; do
      substituteInPlace src/python/lib/''${f} \
        --replace-fail \
          'pyflowDir=os.path.join(scriptDir,"pyflow")' \
          'pyflowDir="${pyflow}/${pythonEnv.sitePackages}"'
    done

    # Special case
    substituteInPlace src/python/lib/strelkaSomaticWorkflow.py \
      --replace-fail \
        'sys.path.append(os.path.join(scriptDir,"pyflow"))' \
        'sys.path.append("${pyflow}/${pythonEnv.sitePackages}")'
  '';

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    boost
    curl
    pythonEnv
    zlib
  ];

  propagatedBuildInputs = [ pythonEnv ];

  cmakeFlags = [
    (lib.cmakeFeature "CMAKE_CXX_STANDARD" "14")
  ];

  env = {
    NIX_CFLAGS_COMPILE = toString [
      "-Wno-error=maybe-uninitialized"
      "-Wno-error=array-bounds"
    ];
    CXXFLAGS = "-I${htslib}/include -I${rapidjson}/include";
    LDFLAGS = "-L${htslib}/lib -lhts";
  };

  meta = {
    description = "Germline and small variant caller";
    license = lib.licenses.gpl3;
    homepage = "https://github.com/Illumina/strelka";
    maintainers = with lib.maintainers; [ jbedo ];
    platforms = lib.platforms.linux;
  };
})
