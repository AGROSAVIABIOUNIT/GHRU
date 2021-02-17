# __**cutadapt-nextflow**__

This process put together cutadapt and nextflow for <br> scalable cleaning internal adapters contamination of <br>
raw reads <br>

###**pre-requisites:**

   conda ( pip3 install conda )

###**Create manually conda env (optional)**
 
   conda create --name cutadapt --file <br> conda_env_nextflow_cutadapt.txt <br>

##_**Run**_

###**Edit two first lines in (.sh) file with paths <br>
to nextflow_pipelines directory and data into fastqs <br> directory** <br>

   sh file.sh

Have a look on your fastqs pattern <br>
 (ej.'*{_,R}{1,2}.f*q.gz') <br>

prunning -> adapter_cleaning <br>
prunning2 -> polyAAA_cleaning <br>


## **Now, you recovered your unvaluable files!!**
