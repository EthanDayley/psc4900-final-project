# Data Source

The data for this project is from the NCBI GEO database.
The link to the original article is https://doi.org/10.1016/j.pneurobio.2020.101939.
The link to the GEO Accession Display is https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE149382.

# Preparation

The following directory structure is assumed for this project:

 ```
`-- raw_data
|-- fastq_runs
`-- results
    |--  1_initial_qc
    |-- 2_trimmed_output
    |-- 3_rRNA
    |-- 4_aligned_sequences
    |-- 5_final_counts
    |-- 6_multiQC
    `-- 7_diff_exp
```
This directory structure should be included with the repo if you have cloned it.


# Data Fetching

Firstly, the SRA toolkit version 2.9.6.1 was loaded.
The SRA toolkit was then used to fetch the experimental data by first saving the accession list
data files to the raw_data/ directory. Next, the command ```fastq-dump -O fastq_runs/ raw_data/*``` was used to extract
fastq files from the downloaded runs.

*NOTE: the accession list is included in this directory as  SraAccList.txt."*

Next we fetched the reference genomes for Mus Musculus with the following commands:
```shell
wget -P genome/ ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M12/GRCm38.p5.genome.fa.gz
wget -P annotation/ ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M12/gencode.vM12.annotation.gtf.gz
```

# 1 - Initial QC

FastQC was used for the initial quality control as follows:
* The parallel module was loaded with `module load parallel`
* The appropriate version of FastQC was loaded: ```module load fastqc/0.11.9```
* FastQC was run in parallel on the different runs with the command ```parallel "fastqc -o results/1_initial_qc {}" ::: fastq_runs/*.fastq```

# 2 - Trim Sequences

TrimGalore was used for trimming low-quality sequences from the runs with the following command:
```shell
sbatch run_trim_galore.slurm.sh
```

# 3 - Remove Ribosomal RNA Fragments

SortMeRNA was used to remove rRNA fragments from our samples.
First we fetched the SortMeRNA database with the following commands:
```shell
wget -P sortmerna_db https://github.com/biocore/sortmerna/archive/2.1b.zip
unzip sortmerna_db/2.1b.zip -d sortmerna_db
mv sortmerna_db/sortmerna-2.1b/rRNA_databases/ sortmerna_db/
rm sortmerna_db/2.1b.zip
rm -r sortmerna_db/sortmerna-2.1b
```

Next, we ran the slurm batch script _run_sortmerna.slurm.sh_ to filter out the rRNA.
We then moved the files to their correct places with the following sequence of commands:
```shell
cd results/3_trimmed_output/
mkdir logs
mv aligned/*.log logs/
cd ../../
```

# 4 - Align With STAR

STAR was used to align our sequences. It was run as a slurm script with the following command:
```bash
sbatch run_star.slurm.sh
```
The files were then moved to the appropriate directory with the following commands:
```bash
mkdir results/4_aligned_sequences/aligned_bam
mv -v *.bam results/4_aligned_sequences/aligned_bam/
mkdir results/4_aligned_sequences/aligned_logs
mv -v *.out *.tab results/4_aligned_sequences/aligned_logs/
```

# 5  - Summarize Gene Counts with FeatureCounts

FeatureCounts was used to summarize gene counts for our samples. This was accomplished with the following set of commands:
```shell
cd results/4_aligned_sequences/aligned_bam/
featureCounts -a ../../../annotation/gencode.vM12.annotation.gtf -o final_counts.txt -g 'gene_name' -T 16 $dirlist
mv final_counts.txt* ../../5_final_counts/
cd ../../../
```

# 6 - Generate Analysis Report with MultiQC

We then used MultiQC to generate an analysis report with the following command:
```shell
multiqc results --outdir results/6_multiQC
```
