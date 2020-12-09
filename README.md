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

# 1 - Initial QC

FastQC was used for the initial quality control as follows:
* The parallel module was loaded with `module load parallel`
* The appropriate version of FastQC was loaded: `module load fastqc/0.11.9`
* FastQC was run in parallel on the different runs with the command `parallel "fastqc -o results/1_initial_qc {}" ::: fastq_runs/*.fastq`

# 2 - Trim Sequences


