# __**coV2-nextflow**__

This process generate a phylogeny inference and lineages <br> 
assignment of sars_cov2 based on mapping to reference <br> 
Wuhan_1, quality filters (cov and max-ambig), trees generation <br> 
and pangolin prediction software, using nextflow and conda envs <br>
to make scalable and easy to use with updated data <br>

**pre-requisites:**

   conda ( pip3 install conda )

**Create manually conda env (optional)**
 
   conda create --name cov --file cov_env.txt <br>

## _**Run**_

**Edit two first lines in (.sh) file with paths <br>
to nextflow_pipelines directory (default .) and to fasta file** <br>

   bash file.sh


## **Access to easy sars_cov2 genomic data analysis is essential 
to predict risks in LMICs!!**
