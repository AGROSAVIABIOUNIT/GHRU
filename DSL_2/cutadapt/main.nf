nextflow.enable.dsl=2
//#!/usr/bin/env nextflow
params.input_dir = false
params.output_dir = false
params.fastq_pattern = false
params.adapter_file = false

include { CUTADAPT } from './process'

if (params.input_dir && params.output_dir) {
sample_id_and_reads = Channel
        .fromFilePairs("${params.input_dir}/${params.fastq_pattern}")
        .ifEmpty { error "Cannot find any reads matching: ${params.input_dir}/${params.fastq_pattern}"}
}
workflow {
CUTADAPT(sample_id_and_reads, params.adapter_file)
}