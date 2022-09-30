#!/bin/bash
#PBS -N FASTA
#PBS -q serial
#PBS -P CBBI1369
#PBS -l select=1:ncpus=24
#PBS -l walltime=48:00:00


### specify config file directory to load the config file
. /mnt/lustre/users/lrothmann/shotgun_meta/bin/config.sh

# set the working directory
wkdir=k

### convert fastq files to fasta format using awk

while read ID
do
    cat ${fastq}${ID}.fastq | awk '{if(NR%4==1) {printf(">%s\n",substr($0,2));} 
    else if(NR%4==2) print;}' > ${outfa}${ID}.fa
done<samples.txt


### note that samples.txt is a text file that contains the unique SRR codes for the fastq files
