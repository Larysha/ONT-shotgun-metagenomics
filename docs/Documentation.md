# Documentation 

Shotgun metagenomics includes sequencing all genomic DNA from an environmental sample (e.g., a water sample) , which means it contains mixed populations that are sequenced in parallel. The genomes may be different sizes and mixed with host DNA. 
ONT technology can span mega-bases in a single read and these longer reads are a major benefit. High molecular weight DNA (HMW) is often used in ONT, but there is a trade-off between read length and yield.  Inputs include ds DNA, cDNA (with optional amplification) or direct RNA.
ONT limitations include higher error rates and relatively high amounts of nucleic acid is required. Its principal strength remains the ultra long read length, which is especially useful in assembly. It also allows for the sequencing of a single, native molecule (no PCR bias).

This project includes scripts for a typical shotgun metagenomics downstream analysis pipeline using ONT reads.

## Scripts (in order of pipeline):

1. `config.sh`
2. `data_download.sh`
3. `longqc.sh`
4. `fastq_to_fasta`
5. `classify.sh`
6. `krona.sh`
7. `metaflye.sh`
8. `quast.sh`
9. `medaka.sh`
10. `busco.sh`

The `config.sh` file is an optional file that sets the the working directory paths to specific variables - if you load it once, then the working directory can be changed easily throughout a working session

## Data Acquisition with sra-toolkit

*Optional*

To test this pipeline, all data was downloaded from the NCBI SRA database using the `sra-toolkit V. 2.10.9`. This included two runs  (SRR9648445 and SRR9648446) prepared using 1D Rapid PCR Barcoding Kit (SQK-RPK004), sequenced with MinION device with FLO-MIN106 (R9.4) flowcell.

The samples have been base-called, demultiplexed and the adaptors have been trimmed with `ONT-Guppy`  - propriety software from ONT and built into the miniKNOW platform to run in real-time during sequencing. 

To download: for large datasets in SRA format, `prefecth` can be used 

```bash
$ prefetch  SRR9648445  # for a single file
$ prefetch  SRR9648445 SRR9648446  # multiple files
$ prefetch SRR.txt # for multiple SRR files recorded in a text file
```

`fastq-dump` or `fasterq-dump` can be used to convert a SRA file to `fastq` format (`fasterq-dump` is faster with multithreading)

If you want to download a file directly in `fastq` format, the `prefetch` step is unnecessary and multiple files can be downloaded using this loop:

```bash
for ((i=45; i<=46; i++)) #adjust the values of i accordingly
    do
    fastrq-dump --accession SRR96484$i  # adjust the SRR ID accordingly
done
```

## Quality control with LongQC

LongQC is a tool specifically designed to handle ONT long reads for quality control and accepts `fasta` , `fastq` or `BAM` file formats (even without quality scores). The `fastq` files are used here.

 Download LongQC to the same location as your `fastq` files - installation instructions can be found here: [https://github.com/yfukasawa/LongQC](https://github.com/yfukasawa/LongQC)

```bash
#  list all fastq file into a file called samples.txt
ls SRR*.fastq>samples.txt

# set variables fastq and outfq in the script 
fastq=/path/to/fastq/file
outfq=/path/to/output/files

```

You can now run the `longQC.sh` script. Note that the `ont-rapid` argument is set in this script - change to `ont-ligation` for PCR-free samples. Also adjust the SRR variable to suit your files.

## Taxonomic classification with Kraken2

Kraken is a taxonomic sequence classifier that assigns taxonomic labels to DNA sequences by examining k-mers within a query sequence to compare to a database and map the k-mers to the lowest common ancestor. Kraken2 is on the CHPC server but if you are using your local device, note that construction of the Kraken2 standard database requires ~ 100GB of disk space. You can also create your own own custom database, should the need arise. Installation and set up of the database instructions can be found here: [https://github.com/DerrickWood/kraken2/wiki/Manual#special-databases](https://github.com/DerrickWood/kraken2/wiki/Manual#special-databases)

### First, convert the `fastq` files to `fasta` format:

In the `fastq_to_fasta.sh` script, set the `fastq` variable to the location of your `fastq`and `samples.txt` files  (remember that `samples.txt` is the file listing the unique SR IDs of the `fastq` files). Now run the script `fastq_to_fasta.sh`.

The `fasta` files are the input for kraken2 analysis:

```bash
# set variables DB and wkdir in the script
DB=/path/to/kraken/standanrd/database
wkdir=/path/to/working/dir
```

You can now run the script `[classify.sh](http://classify.sh)`  It is recommended to run the script with the `- -report` option and without it, to generate two outputs:

**The default is kraken standard output, which contains five tab-delimited fields:**

1. "C"/"U": a one letter code indicating that the sequence was either classified or unclassified.
2. The sequence ID, obtained from the FASTA/FASTQ header.
3. The taxonomy ID Kraken 2 used to label the sequence; this is 0 if the sequence is unclassified.
4. The length of the sequence in bp. In the case of paired read data, this will be a string containing the lengths of the two sequences in bp, separated by a pipe character, e.g. "98|94".
5. A space-delimited list indicating the LCA mapping of each kmer in the sequence(s). For example, "562:13 561:4 A:31 0:1 562:3" would indicate that:
    - the first 13 *k-mers* mapped to taxonomy ID #562
    - the next 4 *k-mers* mapped to taxonomy ID #561
    - the next 31 *k-mers* contained an ambiguous nucleotide
    - the next *k-mer* was not in the database
    - the last 3 *k-mers* mapped to taxonomy ID #562

**Whereas the report format has the following fields (from left to right):**

1. Percentage of fragments covered by the clade rooted at this taxon
2. Number of fragments covered by the clade rooted at this taxon
3. Number of fragments assigned directly to this taxon
4. A rank code, indicating (U)nclassified, (R)oot, (D)omain, (K)ingdom, (P)hylum, (C)lass, (O)rder, (F)amily, (G)enus, or (S)pecies. Taxa that are not at any of these 10 ranks have a rank code that is formed by using the rank code of the closest ancestor rank with a number indicating the distance from that rank. E.g., "G2" is a rank code indicating a taxon is between genus and species and the grandparent taxon is at the genus rank.
5. NCBI taxonomic ID number
6. Indented scientific name

## Visualization with Krona

Kraken standard output files can be visualized with Krona to display the hierarchical taxonomic assignment data in a multilayered pie-chart. It produces a interactive `html` file that can be viewed in a browser. The tool `ktImportTaxonomy` will parse the the information of the query ID and taxonomy ID to `html` format.

Some of the options available in ktImportTaxonomy:

| Option  | Function |
| --- | --- |
| -q <integer> | Column of input files to use as query ID. |
| -t <integer> | Column of input files to use as taxonomy ID. |
| -o <string> | Output file name. |

It is recommended that krona is installed with conda/miniconda ([https://docs.conda.io/en/latest/miniconda.html](https://docs.conda.io/en/latest/miniconda.html)):

Krona documentation is available at [https://github.com/marbl/Krona/wiki](https://github.com/marbl/Krona/wiki)

This is from the script `krona.sh`

```bash
# install krona with miniconda
conda create --yes -n krona krona
# activate krona
conda activate krona

# create a sym link between the downloaded dir and the wkdir
ln -s /mnt/c/Users/path/to/wkdir /home/usrname/miniconda3/envs/krona/opt/krona/taxonomy

# run the update files
ktUpdateTaxonomy.sh ~/path/to/files

# build a 2 column file `read_id<tab>tax_id` as input for the ktImportTaxonomy tool for each file that only contains "C" or classified data only
grep "C" file.kraken | cat | cut -f 2,3 > file.krona

# run the ImportTaxonomy tool
ktImportTaxonomy 45_C.krona
# visualise the output in the browser
firefox taxonomy.krona.html
```

## Metagenome Assembly with MetaFlye

`Flye` is recommended by ONT for *de novo* genome assembly - it has a metagenome assembly mode for non-uniform coverage and higher repeat content, assigned with the option `--meta` The alternative tool, `Canu`, has a slightly lower error rate but it is much more time intensive.

The script [`metaflye.sh`](http://metaflye.sh) works for all `.fastq` files in the `wkdir` - adjust this variable in the script to your own working directory path. The option `--nano-corr` has been set in this script for error corrected ONT reads but can be changed - refer to docs: [https://github.com/fenderglass/Flye/blob/flye/docs/USAGE.md](https://github.com/fenderglass/Flye/blob/flye/docs/USAGE.md) 

### Visualization of assembly and BLAST with Bandage

`Bandage` is a visualization program specifically for *de novo* assembly graphs and accepts the `GFA` generated by `Flye`. Nodes in the graph represent contigs and the connections between the contigs are shown too. Nodes can be labelled according to length, depth or ID. Sequence information can be directly extracted from the graph, which is useful to `BLAST` specific contigs (also built into `Bandage` ).

### Quality assessment of the assembly with MetaQuast

MetaQuast is a genome assembly evaluation tools based on alignment of contigs to a reference genome, which specifically addresses metagenome related issues such as unknown species content , multiple genomes and relative species.

This is applied to the `filtered_contigs.fa` output of MetaFlye

script `quast.sh`

### Medaka

Medaka is recommended by ONT and creates a consensus sequence and variant calls from sequencing data by comparing reads against a draft assembly

```sql
# make a single file for all basecalling files in fatsq format
[lrothmann@login1 quast]$ cat *.fastq >> all.fastq
[lrothmann@login1 quast]$ ls
SRR9648445.fastq  SRR9648446.fastq  all.fastq  assembly.fasta  consensus.fasta  filtered_contigs.fasta
```

script `medaka.sh`

### BUSCO

This is a tool for assessing the genome annotation and assembly completeness based on evolutionary informed expectations of gene content. BUSCO and Quast can be used together to assess the assembly.  file `busco.sh`

```bash
# the `auto-lineage-prok` option is given so that busco finds the most suitable lineage from the available prokaryotes. A specific lineage can be set too.
busco -i assembly.fasta -o busco_out -m genome --auto-lineage-prok
```
