# Data Source

The dataset for this project was sourced from the NCBI SRA database.
The link to the associated BioProject is https://www.ncbi.nlm.nih.gov/bioproject/PRJNA376454.

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
as SraAccList.txt and then running `prefetch --option-file SraAccList.txt -O  raw_data/` to save the SRA
data files to the raw_data/ directory. Next, the command `fastq-dump -O fastq_runs/ raw_data/*` was used to extract
fastq files from the downloaded runs.

*NOTE: the accession list is included in this directory as  SraAccList.txt."*
