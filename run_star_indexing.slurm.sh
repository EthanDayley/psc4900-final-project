#!/bin/bash

#SBATCH --job-name=star_indexing_job
#SBATCH --account=$USER
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --partition=guru
#SBATCH --output=star_indexing_slurm-%j.out

echo "Beginning star indexing"

STAR --runMode genomeGenerate --genomeDir star_index --genomeFastaFiles genome/* --sjdbGTFfile annotation/* --runThreadN 32

echo "** FINISHED ALL STAR INDEXING **"
