#!/bin/bash

#SBATCH --job-name=star_alignment_job
#SBATCH --account=$USER
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --partition=guru
#SBATCH --output=star_alignment_slurm-%j.out

echo "Beginning star alignment"

for i in $(ls results/3_rRNA/filtered)
do
	STAR --genomeDir star_index \
		--readFilesIn results/3_rRNA/filtered/${i} \
		--runThreadN 16 --outFileNamePrefix $i. \
		--outSAMtype BAM SortedByCoordinate \
		--quantMode GeneCounts
done

echo "** FINISHED ALL STAR ALIGNMENT **"
