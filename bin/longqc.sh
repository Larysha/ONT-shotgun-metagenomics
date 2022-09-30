#!/bin/bash
#PBS -N align
#PBS -q serial
#PBS -P CBBI1369
#PBS -l select=1:ncpus=24
#PBS -l walltime=48:00:00

module load chpc/BIOMODULES
module load longQC

### list all Fastq files in folder and read them into a folder called samples.txt
### ls SRR*.fastq>samples.txt

### ensure only the unique key names or IDs are in the file

### specify the path to the fastq files and the output folder

fastq=/mnt/lustre/users/lrothmann/work/longQC
outfq=/mnt/lustre/users/lrothmann/work/longQC/fastq

### run longQC on each of the samples based and output a folder with results for each

while read ID
do
	echo ${fastq}${ID}.fastq
	python longQC.py sampleqc -x ont-rapid -o ${outfq}${ID}_out SRR96484${ID}.fastq
done<samples.txt

### note that samples.txt is a text file that contains the unique codes for the fastq files
