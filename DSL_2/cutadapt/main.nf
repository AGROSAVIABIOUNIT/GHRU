nextflow.enable.dsl=2

params.input_dir = false
params.output_dir = false
params.fastq_pattern = false
params.adapter_file = false

include { QC_PRE_PRUNING; PRE_FASTQC_MULTIQC; CUTADAPT; QC_POST_PRUNING; POST_FASTQC_MULTIQC } from './process'

if (params.input_dir && params.output_dir) {
sample_id_and_reads = Channel
        .fromFilePairs("${params.input_dir}/${params.fastq_pattern}")
        .ifEmpty { error "Cannot find any reads matching: ${params.input_dir}/${params.fastq_pattern}"}
}
workflow {
QC_PRE_PRUNING(sample_id_and_reads)
PRE_FASTQC_MULTIQC(QC_PRE_PRUNING.out.pre_fastqc_directories.collect())
CUTADAPT(sample_id_and_reads, params.adapter_file)
QC_POST_PRUNING(CUTADAPT.out.pruned_to_qc)
POST_FASTQC_MULTIQC(QC_POST_PRUNING.out.post_fastqc_directories.collect())
}