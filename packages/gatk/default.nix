{
  lib,
  stdenv,
  fetchzip,
  jre,
  makeWrapper,
  python3,
  gcc,
  glibc,
  fetchPypi,
  unzip
}:

let
  pythonWithPackages = python3.withPackages (ps: with ps; [
    numpy
    scipy
    pytorch
    pymc3
    keras
    scikit-learn
    matplotlib
    pandas
    biopython
#    pyvcf # not used and not maintained by nixpkgs anymore
    pysam
    setuptools
    pip
  ]);
in

stdenv.mkDerivation rec {
  pname = "gatk";
  # CNNScoreVariants is no longer included in GATK as of version 4.6.1.0.
  version = "4.6.0.0";
  src = fetchzip {
    url = "https://github.com/broadinstitute/gatk/releases/download/${version}/gatk-${version}.zip";
    sha256 = "sha256-AwGRkgVbG2gA4K1JG0WPr4v18JHG5YzYUKdJ2EJZX+Y=";
  };

  nativeBuildInputs = [ makeWrapper unzip ];
  buildInputs = [ python3 gcc.cc.lib glibc ];

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/bin
    install -m755 -D $src/gatk-package-${version}-local.jar $out/bin/
    install -m755 -D $src/gatk-package-${version}-spark.jar $out/bin/
    install -m755 -D $src/gatk $out/bin/

      # Extract and install GATK Python packages
    mkdir -p $out/lib/python/site-packages
    cd $out/lib/python
    unzip -q $src/gatkPythonPackageArchive.zip

    # Simply copy all Python modules directly to site-packages
    cp -r gatktool $out/lib/python/site-packages/
    cp -r gcnvkernel $out/lib/python/site-packages/
    cp -r vqsr_cnn $out/lib/python/site-packages/
  '';

  postFixup = ''
    # Ensure the Python path includes both the GATK packages and the base Python packages
    wrapProgram $out/bin/gatk \
      --prefix PATH : ${lib.makeBinPath [ jre pythonWithPackages ]} \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath [ gcc.cc.lib glibc ]} \
       --prefix PYTHONPATH : "$out/lib/python/site-packages:${pythonWithPackages}/${pythonWithPackages.sitePackages}"

    # Test that gatktool can be imported
    echo "Testing gatktool import..."
    PYTHONPATH="$out/lib/python/site-packages:${pythonWithPackages}/${pythonWithPackages.sitePackages}" \
      ${pythonWithPackages}/bin/python -c "import gatktool; print('gatktool successfully imported')" || echo "Warning: gatktool import failed"
  '';

  meta = with lib; {
    homepage = "https://gatk.broadinstitute.org/hc/en-us";
    description = "Wide variety of tools with a primary focus on variant discovery and genotyping.";
    license = licenses.asl20;
    sourceProvenance = with lib.sourceTypes; [ binaryBytecode ];
    maintainers = with maintainers; [ apraga ];
    longDescription = ''
      The GATK is the industry standard for identifying SNPs and indels in germline
      DNA and RNAseq data. Its scope is now expanding to include somatic short variant
      calling, and to tackle copy number (CNV) and structural variation (SV). In
      addition to the variant callers themselves, the GATK also includes many
      utilities to perform related tasks such as processing and quality control of
      high-throughput sequencing data, and bundles the popular Picard toolkit.

      These tools were primarily designed to process exomes and whole genomes
      generated with Illumina sequencing technology, but they can be adapted to handle
      a variety of other technologies and experimental designs. And although it was
      originally developed for human genetics, the GATK has since evolved to handle
      genome data from any organism, with any level of ploidy.
    '';
  };
}
