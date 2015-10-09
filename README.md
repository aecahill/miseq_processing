# miseq_processing

mothur_pipeline_updated is the code needed to run a fastq file through MOTHUR to get count tables for each well and locus. Those files then go into the counttables code. (update 9 october)

Code related to processing the miseq data

counttables takes the count_table file from MOTHUR and processes it to determine the most abundant read in a list of files.

extractseqs takes that list of abundant reads and extracts the corresponding list of sequences from a set of fasta files.

