params.output_dir = false

//qc_pre_pruning

process QC_PRE_PRUNING {
    tag { sample_id }
    conda 'fastqc=0.11.9'
    publishDir "${params.output_dir}/fastqc_reports/pre_pruning",
        mode: 'copy',
        pattern: "*.html"
    
    input:
    tuple(val(sample_id), path(reads))

    output:
    path('*.html')
    path("*_fastqc_data"), emit: pre_fastqc_directories


    script:
    if (params.input_dir) {
      r1_prefix = reads[0].baseName.replaceFirst(/\\.gz$/, '').split('\\.')[0..-2].join('.')
      r2_prefix = reads[1].baseName.replaceFirst(/\\.gz$/, '').split('\\.')[0..-2].join('.')
    """
    fastqc ${reads[0]} ${reads[1]} --extract
    # rename files
    mv ${r1_prefix}_fastqc/summary.txt ${sample_id}_R1_fastqc.txt
    mv ${r2_prefix}_fastqc/summary.txt ${sample_id}_R2_fastqc.txt

    # move files for fastqc
    mkdir ${r1_prefix}_fastqc_data
    mkdir ${r2_prefix}_fastqc_data
    mv ${r1_prefix}_fastqc/fastqc_data.txt ${r1_prefix}_fastqc_data
    mv ${r2_prefix}_fastqc/fastqc_data.txt ${r2_prefix}_fastqc_data
    """
    }
}
//FastQC MultiQC
process PRE_FASTQC_MULTIQC {
  tag { 'multiqc for fastqc' }
  memory { 4.GB * task.attempt }
  conda 'multiqc=1.9'
  publishDir "${params.output_dir}/multiqc_reports/pre_pruning",
    mode: 'copy',
    pattern: "multiqc_report.html",
    saveAs: { "fastqc_multiqc_report.html" }

  input:
  path(pre_fastqc_directories) 

  output:
  path("multiqc_report.html")

  script:
  """
  multiqc --interactive .
  """
}
// Cutadapt

process CUTADAPT {
  tag { sample_id }
  conda 'cutadapt=3.1' 
  publishDir params.output_dir,
  mode:'copy',
  pattern: 'pruned_fastqs/*.f*q.gz'
  
  input:
  tuple(val(sample_id), path(reads) )
  path('adapter_file.fas')

  output:
  path('pruned_fastqs/*.f*q.gz') 
  tuple(val(sample_id), path(reads), emit: pruned_to_qc)  
  
  script:
  
  """
  mkdir pruned_fastqs
  cutadapt -m 50 -j 2 -a file:'adapter_file.fas' -o pruned_fastqs/${reads[0]}  -p pruned_fastqs/${reads[1]} ${reads[0]} ${reads[1]}
  """
}
// Post-Pruning QC
process QC_POST_PRUNING {
  tag { sample_id }

  publishDir "${params.output_dir}/fastqc_reports/post_pruning",
    mode: 'copy',
    pattern: "*.html"
  
  input:
  tuple(val(sample_id), path(reads))

  output:
  path('*.html')
  path("*_fastqc_data"), emit: post_fastqc_directories

  script:
  if (params.input_dir) {
  r1_prefix = reads[0].baseName.replaceFirst(/\\.gz$/, '').split('\\.')[0..-2].join('.')
  r2_prefix = reads[1].baseName.replaceFirst(/\\.gz$/, '').split('\\.')[0..-2].join('.')
  """
  fastqc ${reads[0]} ${reads[1]} --extract
  # rename files
  mv ${r1_prefix}_fastqc/summary.txt ${sample_id}_R1_fastqc.txt
  mv ${r2_prefix}_fastqc/summary.txt ${sample_id}_R2_fastqc.txt

  # move files for fastqc
  mkdir ${r1_prefix}_fastqc_data
  mkdir ${r2_prefix}_fastqc_data
  mv ${r1_prefix}_fastqc/fastqc_data.txt ${r1_prefix}_fastqc_data
  mv ${r2_prefix}_fastqc/fastqc_data.txt ${r2_prefix}_fastqc_data
  """
  }
}

//FastQC MultiQC
process POST_FASTQC_MULTIQC {
  tag { 'multiqc for fastqc' }
  memory { 4.GB * task.attempt }

  publishDir "${params.output_dir}/multiqc_reports/post_pruning",
    mode: 'copy',
    pattern: "multiqc_report.html",
    saveAs: { "fastqc_multiqc_report.html" }

  input:
  path(post_fastqc_directories) 

  output:
  path("multiqc_report.html")

  script:
  """
  multiqc --interactive .
  """
}
