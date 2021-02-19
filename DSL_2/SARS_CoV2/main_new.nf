nextflow.enable.dsl=2
params.fasta_file = false
params.output_dir = false
params.reference = false

include { RUN_MINIMAP; RUN_SAM_2_FASTA; FILTER_COVG_LENGTH; FASTTREE; ROOT_TREE; LINEAGES_PANGOLIN } from './processes_new'

workflow {
  if (params.fasta_file && params.output_dir) {
    fastas = Channel
    .from(params.fasta_file)
    .ifEmpty { error "Cannot find any fastas matching: ${params.fasta_file}" }
    
    RUN_MINIMAP(fastas, params.reference)
    RUN_SAM_2_FASTA(RUN_MINIMAP.out.sam_files, params.reference)
    FILTER_COVG_LENGTH(RUN_SAM_2_FASTA.out)
    FASTTREE(FILTER_COVG_LENGTH.out)
    ROOT_TREE(FASTTREE.out)
    LINEAGES_PANGOLIN(fastas)
  }
}
