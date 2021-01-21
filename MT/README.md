# __**MultiTyper v0.2**__

This process packaged together typing software for different species include Salmonella spp., Escherichia coli, Enterococcus sp.(*), Neisseria gonorrhoeae, Streptococcus pneumoniae(*) and scalable using nextflow

## Software per specie

Salmonella: Seqsero2 v1.1.1, Sistr_cmd v1.1.1 <br>
Ecoli: Ectyper v1.0.0 <br>
Enterococcus: CHEWBBAKKA <br>
Neisseria gonorrhoeae: Ng-master v0.5.6<br>
Streptococcus pneumoniae: Pneumocat, Seroba <br>

*not available in this version - comming soon!!

## **nextflow** install (optional)

_sh scripts/auto_nextflow_install.sh_

## **conda** install (optional). Remember to close the terminal after run auto_conda_install and set auto-activate false 

_sh scripts/auto_conda_install.sh_ <br>
_conda config --set auto_activate_base false_ <br>

## edit path to nextflow scripts and data base directories, and define specie into the run file **"run_mt_pipeline_test.sh"** 

_NEXTFLOW_PIPELINE_DIR=/path/to/nf_files_base_directory_ <br>
_DATA_DIR=/path/to/data_base_directory_ <br>
_SPECIES= Salmonella or Ecoli or Ngono_ <br>

## run **MT**

_bash run_mt_pipeline_test.sh_

# All fasta sequences used as examples for MT were downloaded from refseq NCBI ( https://www.ncbi.nlm.nih.gov/ )

## **All in one site!!**
