#!/usr/bin/env nextflow
params.input_dir = false
params.output_dir = false
params.fasta_pattern = false
params.specie = false

if (params.input_dir) {
  input_dir = params.input_dir - ~/\/$/
  output_dir = params.output_dir - ~/\/$/
  fasta_pattern = params.fasta_pattern
  fasta_file = input_dir + '/' + fasta_pattern
  Channel
    .fromPath(fasta_file)
    .ifEmpty { error "Cannot find any fastas matching: ${fasta_file}" }
    .set { fastas }
}

//ECtyper
process ectyper {
   memory '2 GB'
   conda 'ectyper=1.0.0'
   publishDir "${output_dir}",
   mode:'copy',
   saveAs: { file -> "ectyper_output/${fasta_file}.tsv"}
 
  input:
  file (fasta_file) from fastas

  output:
  file ('ectyper_output/*.tsv') 

"""
  ectyper -i ${fasta_file} -o ectyper_output

"""
}
