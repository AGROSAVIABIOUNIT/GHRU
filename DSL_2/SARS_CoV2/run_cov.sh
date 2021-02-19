nextflow_pipelines=/path/to/your/nf_file
data_dir=/path/to/fasta_dir

nextflow run ${nextflow_pielines}/main_new.nf \
    --fasta_file ${data_dir}/gisaid_hcov-19_2021_02_16_03_all.fasta 
    --reference ${nextflow_pipelines}/references/MN908947.3.fasta 
    --output_dir cov_output/ 
    -resume
