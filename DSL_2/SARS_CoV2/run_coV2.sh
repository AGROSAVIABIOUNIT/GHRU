#you will need to add updated data to fasta_file dir 
nx_n_data=/path/to/SARS_coV2

nextflow run main.nf \
	--fasta_file ${nx_data}/fasta_file/gisaid_hcov-19_2021_02_16_03_all.fasta \
	--reference ${nx_data}/references/MN908947.3.fasta \
	--output_dir . \
	-resume
