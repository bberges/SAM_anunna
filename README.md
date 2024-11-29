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

### Example 1: example1_slurm.sh, example1_SAMfit.R
The example runs the stock assessment model 10 times.

One can run the code on a normal R session:

- [ ] Set your working directory to the repo root
- [ ] Start R
- [ ] source('./example1_SAM fit.R')

The number of nodes is controlled in the script with the future package (without future.batchtools): plan(multicore, workers=10).

I get the following performances

On my windows machine on a single worker: 71.12 sec
On my windows machine with 10 workers: 43.61 sec
With 10 workers using the future package (example1_slurm.sh): 282.909 sec

With the future.batchtools package, I did not manage to start the R script with a bash script. Though, I am able to run example1_SAMfit_futureBatchtools.R in an R session as follows:

- [ ] Set your working directory to the repo root
- [ ] Start R
- [ ] source('./example1_SAMfit_futureBatchtools.R')
When doing that, the running time is: 187.4 sec

In my study, I need to run the model fit 1000x25 times so I need to improve the optimization substantially for production.
