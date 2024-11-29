#!/bin/bash

#!/bin/bash
# -----------------------------Name of the job-------------------------
#SBATCH --job-name=NSAS.MSE.base
#-----------------------------Output files-----------------------------
#SBATCH --output=output_%j.txt
#SBATCH --error=error_output_%j.txt
#-----------------------------Other information------------------------
#SBATCH --comment='Some comments'

#-----------------------------Required resources-----------------------
#SBATCH --time=5-00:00:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --mem-per-cpu=1G

#-----------------------------Environment, Operations and Job steps----

module load 2023
module load R

cd /home/WUR/berge057/git/wk_WKMSEHerring/

Rscript slurm_simple.R
