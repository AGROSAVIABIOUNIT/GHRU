#!/usr/bin/env nextflow
params.input_dir = false
params.output_dir = false
params.fasta_pattern = false
params.specie = false
params.env_dir = false

if (params.input_dir) {
  input_dir = params.input_dir - ~/\/$/
  output_dir = params.output_dir - ~/\/$/
  fasta_pattern = params.fasta_pattern
  env_dir = params.env_dir
  fasta_file = input_dir + '/' + fasta_pattern
  Channel
    .fromPath(fasta_file)
    .ifEmpty { error "Cannot find any fastas matching: ${fasta_file}" }
    .set { fastas }
}

//Ng-master
process ngmaster {
   memory '2 GB'
   conda "${env_dir}"
   publishDir "${output_dir}",
   mode:'copy',
   saveAs: { file -> "ngmaster_output/${fasta_file}.csv"}
  
  input:
  file (fasta_file) from fastas

  output:
  file ('ngmaster_output/*.csv') 

"""
  mkdir ngmaster_output
  ngmaster --csv ${fasta_file} > ngmaster_output/${fasta_file}.csv 
 
"""
}
