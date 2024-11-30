# Optimizing SAM stock assessment model runs on HPC Anunna

## Installation of packages

- [ ] Set your working directory to the repo root
- [ ] module load 2023
- [ ] module load R
- [ ] Start R
- [ ] renv::restore()

## Description of the code

The code aims building scripts to optimize paralellization for the running of the SAM stock assessment model using the slurm job scheduler.

Paralellization is done with the future package (https://cran.r-project.org/web/packages/future/index.html). In practice, the future.batchtools (https://cran.r-project.org/web/packages/future.batchtools/index.html) package is here to provide support for job schedulers such as slurm.

## Description of the problem

In my study, I need to run the model fit 1000x25 times. The running of the model is extremely slow on anunna so far. I need to improve the optimization substantially for production.

Here the example runs the stock assessment model 10 times, trying to optimize the running time. The task is ran over 10 workers.

On my windows machine, running the script in a normal R session with and without paralellization, I get the following performances:

On a single worker: 71.12 sec

With 10 workers: 43.61 sec

### Example 1 ran with future from batch file: example1_slurm.sh coupled with example1_SAMfit.R

Here the number of nodes is specified in the bash script (as number of workers --cpus-per-task=10) and the R script (as number of workers, plan(multicore, workers=10)). 

- [ ] sbatch example1_slurm.sh

Performance using the future package (example1_slurm.sh): 282.909 sec

### Example 1 ran with future.batchtools: example1_SAMfit_futureBatchtools.R coupled with slurm.tmpl

With the future.batchtools package, I did not manage to start the R script with a bash script. Instead, I am run example1_SAMfit_futureBatchtools.R which is linked with slurm.tmpl in an R session as follows:

- [ ] Set your working directory to the repo root
- [ ] Start R
- [ ] source('./example1_SAMfit_futureBatchtools.R')

Performance using future.batchtools: 187.4 sec

### Example 1 ran with future.batchtools using GPU: example1_SAMfit_futureBatchtools_GPU.R coupled with slurm_GPU.tmpl

This example is similar to the previous one but adding the use of GPU.

- [ ] Set your working directory to the repo root
- [ ] Start R
- [ ] source('./example1_SAMfit_futureBatchtools_GPU.R')

Performance using future.batchtools with GPU: 499.9 sec
