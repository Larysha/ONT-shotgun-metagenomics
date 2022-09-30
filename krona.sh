#!/bin/bash

#PBS -N BUSCO
#PBS -o /mnt/lustre/users/lrothmann/shotgun_meta/work/busco
#PBS -e /mnt/lustre/users/lrothmann/shotgun_meta/work/busco
#PBS -q serial
#PBS -P CBBI1369
#PBS -l select=1:ncpus=24
#PBS -l walltime=48:00:00

module add chpc/BIOMODULES
module add krona

### specify config file directory to load the config file
. /mnt/lustre/users/lrothmann/shotgun_meta/bin/config.sh

# set the working directory
wkdir=kro

### change to working directory where fastq files are located
cd ${wkdir}

# create a sym link between the downloaded dir and the wkdir
# ln -s /mnt/c/Users/path/to/wkdir /home/usrname/miniconda3/envs/krona/opt/krona/taxonomy

# run the update files
# ktUpdateTaxonomy.sh ~/path/to/files

# build a 2 column file from the output of kraken `read_id<tab>tax_id` as input for the ktImportTaxonomy tool 
# so that each file only contains "C" or classified data
grep "C" file.kraken | cat | cut -f 2,3 > file.krona

# run the ImportTaxonomy tool
ktImportTaxonomy 45_C.krona
# visualise the output in the browser
firefox taxonomy.krona.html
