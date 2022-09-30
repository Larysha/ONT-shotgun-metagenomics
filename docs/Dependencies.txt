# Package dependencies

### SRA-TOOLKIT

Here is a link to a page that outline the dependencies depending the OS: [https://reposcope.com/package/sra-toolkit/dependencies](https://reposcope.com/package/sra-toolkit/dependencies)

### LongQC

LongQC was written in python3 and has dependencies for popular python libraries:

- numpy
- scipy
- matplotlib (version 2.1.2 or higher)
- scikit-learn
- pandas (version 0.24.0 or higher)
- jinja2
- h5py

Also, it depends on some bioinformatics packages.

- pysam
- edlib (with its python wrapper, python-edlib)

### Kraken2

- Linux utilities such as sed, find, and wget.
- Bash shell and Perl.
- Core programs needed to build the database and run the classifier are written in C++11, and need to be compiled using a somewhat recent version of g++ that will support C++11.
- Multithreading is handled using OpenMP.
- Most Linux systems will have all of the above listed programs and development libraries available either by default or via package download.
- By default, Kraken 2 will attempt to use the `dustmasker` or `segmasker` programs provided as part of NCBI's BLAST suite to mask low-complexity regions
    
    **MacOS NOTE:** MacOS and other non-Linux operating systems are *not* explicitly supported by the developers, and MacOS users should refer to the Kraken-users group for support in installing the appropriate utilities to allow for full operation of Kraken 2. We will attempt to use MacOS-compliant code when possible, but development and testing time is at a premium and we cannot guarantee that Kraken 2 will install and work to its full potential on a default installation of MacOS.
    
    In particular, we note that the default MacOS X installation of GCC does not have support for OpenMP. Without OpenMP, Kraken 2 is limited to single-threaded operation, resulting in slower build and classification runtimes.
    

### Krona

[https://github.com/marbl/Krona/wiki/Installing](https://github.com/marbl/Krona/wiki/Installing) 

- NCBI Taxonomy
- accession-to-taxonomyID lookups
- curl

### Flye

- Python 2.7 or 3.5+ (with setuptools package installed)
- C++ compiler with C++11 support (GCC 4.8+ / Clang 3.3+ / Apple Clang 5.0+)
- GNU make
- Git
- Core OS development headers (zlib, ...)

### Medaka

- samtools
- minimap
- tabix
- bgzip
- TensorFlow2.2

### BUSCO

- hmmsearch: 3.1
- bbtools: 39.00
- prodigal: 2.6.3
- busco: 5.4.2
