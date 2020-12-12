#!/bin/bash

#SBATCH --job-name=fastqc_job
#SBATCH --account=$USER
#SBATCH --ntasks=36
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --partition=guru
#SBATCH --output=fastqc_slurm-%j.out

module load fastqc/0.11.9
module load parallel

parallel "fastqc -t 2 -o results/1_initial_qc {}" ::: fastq_runs/*.fastq
