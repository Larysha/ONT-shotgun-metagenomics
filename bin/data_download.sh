#!bin/bash/
#PBS -N SRA
#PBS -q serial
#PBS -P CBBI1369
#PBS -l select=1:ncpus=24
#PBS -l walltime=48:00:00

### load modules
module load chpc/BIOMODULES
module load sra-toolkit/2.10.9


### make a directory for the data to download into e.g. `mkdir data`
### make a config file specifying the path to the directory and assigning it a variable name

### specify config file directory to load the config file
. /mnt/lustre/users/lrothmann/shotgun_meta/bin/0.config.sh

### downlaod the data: two runs (SRR9648445 and SRR9648446) prepared using 1D Rapid PCR Barcoding Kit (SQK-RPK004), 
### sequenced with MinION device with FLO-MIN106 (R9.4) flowcell.

### this code is a loop that allows you to download multiple SRR files in fastq format
### replace the values of i for the min and max accession numbers in your list

### for a larger list of runs, the prefetch command may be neccessary eg: prefetch SRR....


for ((i=45; i<=46; i++))
    do
    fastrq-dump --accession SRR96484$i -O ${data}
done


