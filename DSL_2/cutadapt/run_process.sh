nextflow_workflows_dir=/Users/jfbernal/Downloads/github/AGRO/GHRU/DSL_2/cutadapt
data_dir=/Users/jfbernal/Downloads/github/AGRO/GHRU/DSL_2/cutadapt

nextflow run ${nextflow_workflows_dir}/main.nf \
--adapter_file ${nextflow_workflows_dir}/adapters_cutadapt.fas \
--input_dir ${data_dir}/fastqs \
--fastq_pattern '*{_,R}{1,2}*.f*q.gz' \
--output_dir ${data_dir}/cutadapt_output \
-resume \
-ansi \
-profile standard \
-w ${data_dir}/cutadapt_output/work
