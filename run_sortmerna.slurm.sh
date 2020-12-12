#!/bin/bash

#SBATCH --job-name=sortmerna_job
#SBATCH --account=$USER
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --partition=guru
#SBATCH --output=sortmerna_slurm-%j.out

# between running each sortmerna we need to remove some folders that are automatically created

while read accNum
do
	echo "Running SortMeRNA for $accNum"
	sortmerna --workdir sortmerna_db/ --ref sortmerna_db/rRNA_databases/rfam-5.8s-database-id98.fasta --ref sortmerna_db/rRNA_databases/rfam-5s-database-id98.fasta --ref sortmerna_db/rRNA_databases/silva-arc-16s-id95.fasta --ref sortmerna_db/rRNA_databases/silva-arc-23s-id98.fasta --ref sortmerna_db/rRNA_databases/silva-bac-16s-id90.fasta --ref sortmerna_db/rRNA_databases/silva-bac-23s-id98.fasta --ref sortmerna_db/rRNA_databases/silva-euk-18s-id95.fasta --ref sortmerna_db/rRNA_databases/silva-euk-28s-id98.fasta --reads "/home/edayley/final_project/results/2_trimmed_output/${accNum}_trimmed.fq" --aligned "/home/edayley/final_project/results/3_rRNA/aligned/${accNum}_aligned" --other "/home/edayley/final_project/results/3_rRNA/filtered/${accNum}_filtered" --fastx -threads 48 -v
	rm -r sortmerna_db/idx sortmerna_db/kvdb
	echo "Finished"
	echo ""
done < SraAccList.subset.txt
echo "Finished running for all samples"
