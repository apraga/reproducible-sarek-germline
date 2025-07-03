{
  lib,
  stdenv,
  fetchurl,
  jre,
  python3,
  unzip,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "snpeff";
  version = "4.3t";

  src = fetchurl {
    url = "mirror://sourceforge/project/snpeff/snpEff_v${
      builtins.replaceStrings [ "." ] [ "_" ] version
    }_core.zip";
    sha256 = "0i12mv93bfv8xjwc3rs2x73d6hkvi7kgbbbx3ry984l3ly4p6nnm";
  };

  nativeBuildInputs = [
    makeWrapper
    unzip
  ];
  buildInputs = [ jre ];

  sourceRoot = "snpEff";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/libexec/snpeff
    mkdir -p $out/bin

    cp *.jar *.config $out/libexec/snpeff/

    # Script to reorder arguments
    cp ${./snpeff.py} $out/libexec/snpeff/snpeff.py

    makeWrapper ${python3}/bin/python3 $out/bin/snpEff \
      --add-flags "$out/libexec/snpeff/snpeff.py" \
      --set JAVA_HOME ${jre} \
      --prefix PATH : ${lib.makeBinPath [ jre ]}

    makeWrapper ${jre}/bin/java $out/bin/snpSift --add-flags "-jar $out/libexec/snpeff/SnpSift.jar"
  '';

  meta = with lib; {
    description = "Genetic variant annotation and effect prediction toolbox";
    license = licenses.lgpl3;
    homepage = "https://snpeff.sourceforge.net/";
    sourceProvenance = with sourceTypes; [ binaryBytecode ];
    maintainers = with maintainers; [ jbedo ];
    platforms = platforms.all;
  };

}
