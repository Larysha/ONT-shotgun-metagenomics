#!/bin/bash
#PBS -N ASSEMBLY
#PBS -o /mnt/lustre/users/lrothmann/shotgun_meta/work/Flye/out
#PBS -e /mnt/lustre/users/lrothmann/shotgun_meta/work/Flye/err
#PBS -q serial
#PBS -P CBBI1369
#PBS -l select=1:ncpus=24
#PBS -l walltime=48:00:00

module add chpc/BIOMODULES
module add flye/2.9

### specify config file directory to load the config file
. /mnt/lustre/users/lrothmann/shotgun_meta/bin/config.sh

# set the working directory
wkdir=f

### change to working directory where fastq files are located
cd ${wkdir}

for fq in *.fastq
do
    flye --plasmids --threads 16 --nano-corr $fq --meta --polish-target
done

