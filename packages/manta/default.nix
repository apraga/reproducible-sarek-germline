{
  lib,
  stdenv,
  fetchFromGitHub,
  cmake,
  zlib,
  python2,
}:

stdenv.mkDerivation rec {
  pname = "manta";
  version = "1.6.0";

  src = fetchFromGitHub {
    owner = "Illumina";
    repo = "manta";
    rev = "v${version}";
    sha256 = "1711xkcw8rpw9xv3bbm7v1aryjz4r341rkq5255192dg38sgq7w2";
  };
#rpatches = [ ./boost.patch ] ;
#/Home/Users/apraga/source/build/bootstrap/boost/build/boost_1_58_0/tools/build/src/engine/modules/path.c
# Fix the implicit function declaration error in boost bootstrap
 # Fix GCC 14 compatibility - different flags for boost vs manta
  preConfigure = ''
    # For boost bootstrap phase - only fix the implicit function declaration
    export CFLAGS="-Wno-error=implicit-function-declaration -std=gnu17"
    export CXXFLAGS="-std=gnu++17"
    export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -Wno-error=implicit-function-declaration"
  '';

  # After boost is built, relax flags for manta compilation
  # Cannot disable the last error so remove everythin
  # generateSVCandidates/test/SVScorePairAltProcessorTest.cpp:677:48: error: allocation of insufficient size '0' for type 'uint8_t' {aka 'unsigned char'} with size '1' [8;;https://g>
  preBuild = ''
    echo "Switching to permissive compilation flags for manta..."
    export CFLAGS="-Wno-error=implicit-function-declaration -std=gnu17"
    export CXXFLAGS="-Wno-error -std=gnu++17"
    export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -Wno-error"
  '';
  # preConfigure = ''
  #   # For boost configure with this toolchain
  #   #export CFLAGS="-Wno-error=implicit-function-declaration -std=gnu17"
  #   #export CXXFLAGS="-Wno-error=implicit-function-declaration -std=gnu++17"
  #   # Disable gcc14 (?) errors 
  #   #export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -Wno-error=implicit-function-declaration -Wno-error=array-bounds -Wno-error=alloc-size-larger-than= -Wno-error=vla-larger-than="
  #   #
  #   # Cannot disable the last error so remove everythin
  #   # generateSVCandidates/test/SVScorePairAltProcessorTest.cpp:677:48: error: allocation of insufficient size '0' for type 'uint8_t' {aka 'unsigned char'} with size '1' [8;;https://g>
  #   export CFLAGS="-Wno-error -std=gnu17"
  #   export CXXFLAGS="-Wno-error -std=gnu++17"
  #   export NIX_CFLAGS_COMPILE="$NIX_CFLAGS_COMPILE -Wno-error"
  # '';
  nativeBuildInputs = [ cmake ];
  buildInputs = [
    zlib
    python2
  ];
  postFixup = ''
    sed -i 's|/usr/bin/env python2|${python2.interpreter}|' $out/lib/python/makeRunScript.py
    sed -i 's|/usr/bin/env python|${python2.interpreter}|' $out/lib/python/pyflow/pyflow.py
    sed -i 's|/bin/bash|${stdenv.shell}|' $out/lib/python/pyflow/pyflowTaskWrapper.py
  '';
  doInstallCheck = true;
  installCheckPhase = ''
    rm $out/lib/python/**/*.pyc
    PYTHONPATH=$out/lib/python:$PYTHONPATH python -c 'import makeRunScript'
    PYTHONPATH=$out/lib/python/pyflow:$PYTHONPATH python -c 'import pyflowTaskWrapper; import pyflow'
  '';

  meta = with lib; {
    description = "Structural variant caller";
    license = licenses.gpl3;
    homepage = "https://github.com/Illumina/manta";
    maintainers = with maintainers; [ jbedo ];
    platforms = platforms.x86_64;
  };
}
