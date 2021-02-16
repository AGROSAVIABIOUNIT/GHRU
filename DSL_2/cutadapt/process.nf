// Cutadapt
params.output_dir = false
process CUTADAPT {
  tag { sample_id }
  conda 'cutadapt=3.1' 
  publishDir params.output_dir,
  mode:'copy'
  
  input:
  tuple(val(sample_id), path(reads) )
  path('adapter_file.fas')

  output:
  path('pruned_fastqs/*.f*q.gz')  
  
  script:
  
  """
  mkdir pruned_fastqs
  cutadapt -m 50 -j 2 -a file:'adapter_file.fas' -o pruned_fastqs/${reads[0]}  -p pruned_fastqs/${reads[1]} ${reads[0]} ${reads[1]}
  """
}
