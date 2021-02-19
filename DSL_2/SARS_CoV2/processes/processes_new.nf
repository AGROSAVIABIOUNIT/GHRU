params.output_dir = false

process RUN_MINIMAP {
  publishDir "${params.output_dir}/cov_output", 
  mode: 'copy'

  input:
    path(fasta)
    path(reference)
  
  output:
    path('sam/*.sam'), emit: sam_files
    path('sam/*.log')

  script:

    """
    mkdir sam
    minimap2 -a -x asm5 ${reference} ${fasta} -o sam/${fasta}.sam 2> sam/minimap.log

    """
}

process RUN_SAM_2_FASTA {
   publishDir "${params.output_dir}/cov_output", 
   mode: 'copy'

   input:
   path(sam) 
   path(reference)

   output:
   path('mapped_fastas/*.fasta')

   script:

   """
   mkdir mapped_fastas
   datafunk sam_2_fasta -s ${sam} -r ${reference} -o mapped_fastas/${sam}_.fasta --pad --log-inserts --log-deletions
   """
}

process FILTER_COVG_LENGTH {
   publishDir "${params.output_dir}/cov_output", 
   mode: 'copy'

   input:
   path(fasta_file)

   output:
   path('fasta_filt/*.fasta')
   
   script:

   """
   mkdir fasta_filt
   datafunk filter_fasta_by_covg_and_length  -i ${fasta_file} -o fasta_filt/${fasta_file}_filt.fasta --min-covg 70

   """
}

process FASTTREE {
   publishDir "${params.output_dir}/cov_output", 
   mode: 'copy'

   input:
   path(fasta_filt)
   
   output:
   path('fasttree_output/output.tree')

   script:

   """
   mkdir fasttree_output
   FastTree -gtr -nosupport -nt ${fasta_filt} > fasttree_output/output.tree

   """

}

process ROOT_TREE {
   publishDir "${params.output_dir}/cov_output", 
   mode: 'copy'

   input:
   path(tree_file)

   output:
   path('root_tree/*.nwk')

   script:

   """
   mkdir root_tree
   clusterfunk root --outgroup 'ENA|MN908947|MN908947.3' --in-format newick -i ${tree_file} --out-format newick -o root_tree/rooted_tree.nwk
   """
}

process LINEAGES_PANGOLIN {
   publishDir "${params.output_dir}/cov_output", 
   mode: 'copy'
   conda 'pangolin=2.2.2'
   
   input:
   path(fasta_file)

   output:
   path('linages_pangolin/*.txt')

   script:

   """
   mkdir lineages_pangolin
   pip install git+https://github.com/cov-lineages/lineages.git --upgrade
   pangolin all_LAC.fasta --outdir lineages_pangolin/
   """
}