#!/bin/bash

#PBS -N MEDAKA
#PBS -o /mnt/lustre/users/lrothmann/shotgun_meta/work/medaka
#PBS -e /mnt/lustre/users/lrothmann/shotgun_meta/work/medaka
#PBS -q serial
#PBS -P CBBI1369
#PBS -l select=1:ncpus=24
#PBS -l walltime=48:00:00

module add chpc/BIOMODULES
module add medaka

# set the working directory
wkdir=/mnt/lustre/users/lrothmann/shotgun_meta/work/Medaka/

### change to working directory where fastq files are located
cd ${wkdir}

medaka 
NPROC=$(nproc)
BASECALLS=all.fastq
DRAFT=consensus.fasta
OUTDIR=medaka_consensus
medaka_consensus -i ${BASECALLS} -d ${DRAFT} -o ${OUTDIR} -t ${NPROC} -m r941_min_fast_g507
