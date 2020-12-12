#!/bin/bash

#SBATCH --job-name=trim_galore_job
#SBATCH --account=$USER
#SBATCH --ntasks=36
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --partition=guru
#SBATCH --output=trim_galore_slurm-%j.out

module load fastqc/0.11.9
module load parallel


parallel "trim_galore -j 2 -fastqc -output_dir results/2_trimmed_output/" ::: fastq_runs/*.fastq
