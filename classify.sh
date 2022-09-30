#!/bin/bash
#PBS -N TAX_CLASS
#PBS -o /mnt/lustre/users/lrothmann/shotgun_meta/work/Kraken2/out
#PBS -e /mnt/lustre/users/lrothmann/shotgun_meta/work/Kraken2/err
#PBS -q serial
#PBS -P CBBI1369
#PBS -l select=1:ncpus=24
#PBS -l walltime=48:00:00

module add chpc/BIOMODULES
module add kraken2/2.0.8

### specify config file directory to load the config file
. /mnt/lustre/users/lrothmann/shotgun_meta/bin/config.sh

# set the working directory
wkdir=k

### set DB to the location of the Kraken2 standard database
DB=/mnt/lustre/bsp/DB/KRAKEN2/krakdb

### change to working directory where fasta files are located
cd ${wkdir}

### run Kraken2 with standard database on all fasta files in report format and in raw output format
kraken2 --threads 10 --db $DB --output kraken.output.txt --report kraken.report.txt *.fa
