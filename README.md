# ONT Shotgun Metagenomics Pipeline -Taxonomic Classification and Genome Assembly

All scripts can be found in `bin` 
For the full pipeline documents, please look under `docs` 

This is a repository of scripts and documentation for the analysis of shotgun metagenomic sequencing data generated from Oxford Nanopore Technology (ONT). 

This is a relatively new, exciting technology that sequences DNA or RNA by feeding it through a protein nanopore (hole) in a semi-conductor membrane. A major advantage of this technology is it can generate long reads (up to ~23kb) from a single, native molecule (it can be used without PCR if there is a sufficiently large DNA sample). It is also portable, affordable and can sequence in real-time. The main disadvantage is that there is still a relatively high error rate. 
This project uses a combination of free, third party tools - assuming data base-calling and demultiplexing  of the reads has already been completed by the propriety software, ONT-Guppy.

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

The `config.sh` file is an optional file that sets the working directory paths to specific variables. Loading it will enable the working directory to be changed easily throughout a working session
Please adjust it to suit your file system.

