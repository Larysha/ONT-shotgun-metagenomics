#!/bin/bash

#PBS -N BUSCO
#PBS -o /mnt/lustre/users/lrothmann/shotgun_meta/work/Busco
#PBS -e /mnt/lustre/users/lrothmann/shotgun_meta/work/Busco
#PBS -q serial
#PBS -P CBBI1369
#PBS -l select=1:ncpus=24
#PBS -l walltime=48:00:00

module add chpc/BIOMODULES
module add busco/3.0.2

### specify config file directory to load the config file
. /mnt/lustre/users/lrothmann/shotgun_meta/bin/config.sh

# set the working directory
wkdir=${b}

### change to working directory where fastq files are located
cd ${wkdir}

busco.py -i assembly.fasta -o busco_out -m genome --auto-lineage-prok
