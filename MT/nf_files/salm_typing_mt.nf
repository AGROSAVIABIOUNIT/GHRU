#!/usr/bin/env nextflow
params.input_dir = false
params.output_dir = false
params.fasta_pattern = false
params.species = false

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

//duplicate channels
fastas.into {seqs_seqsero; seqs_sistr}

//seqsero
process seqsero2 {
   memory '2 GB'
   conda 'seqsero2=1.1.1'
   publishDir "${output_dir}",
   mode:'copy',
   saveAs: { file -> "seqsero2_output/${fasta_file}.tsv"}
 

  input:
  file (fasta_file) from seqs_seqsero

  output:
  file('seqsero2_output/*.tsv') 

"""
  SeqSero2_package.py -m k -p 2 -t 4 -i ${fasta_file} -d seqsero2_output
"""
}

//Sistr_cmd
process sistr {
   memory '2 GB'
   conda 'sistr_cmd=1.1.1'
   publishDir "${output_dir}",
   mode:'copy',
   saveAs: { file -> "sistr_output/${fasta_file}.csv"}
 
  input:
  file (fasta_file) from seqs_sistr

  output:
  file ('sistr_output/results.csv') 

"""
mkdir sistr_output
sistr --qc -vv --alleles-output sistr_output/allele-results.json --novel-alleles sistr_output/novel-alleles.fasta --cgmlst-profiles sistr_output/cgmlst-profiles.csv -f csv -o sistr_output/results.csv ${fasta_file}

"""
}
