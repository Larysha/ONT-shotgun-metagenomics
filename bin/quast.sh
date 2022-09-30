#!/bin/bash

#PBS -N QUALITY CONTROL
#PBS -o /mnt/lustre/users/lrothmann/shotgun_meta/work/QUAST/out
#PBS -e /mnt/lustre/users/lrothmann/shotgun_meta/work/QUAST/err
#PBS -q serial
#PBS -P CBBI1369
#PBS -l select=1:ncpus=24
#PBS -l walltime=48:00:00

module add chpc/BIOMODULES
module add flye/2.9
module add python/3.9.6

### specify config file directory to load the config file
. /mnt/lustre/users/lrothmann/shotgun_meta/bin/config.sh

# set the working directory
wkdir=q

### change to working directory where fastq files are located
cd ${wkdir}

metaquast.py filtered_contigs.fasta
