# slurm.R - RUN multiple calls to an R function using slurm in anunna.
# /slurm.R

# Copyright Iago MOSQUEIRA (WMR), 2021
# Author: Iago MOSQUEIRA (WMR) <iago.mosqueira@wur.nl>
#
# Distributed under the terms of the EUPL-1.2

# LOAD modules

# module load tmux

# module load R/4.0.2
# module load gcc/7.2.0

# https://future.batchtools.futureverse.org/
# https://dofuture.futureverse.org/

library(doFuture)
library(future.batchtools)
library(FLCore)
library(FLSAM)
library(stockassessment)

# SETUP slurm plan: assign time and memory per process

#future::plan(
#  future.batchtools::batchtools_slurm,
#  template="~/slurm.tmpl",
  # RESOURCES
#  resources=list(
    # time per process (min)
#    walltime=60,
    # memory per process (Mb)
#    memory=1000,
    # No. CPUs, leave at 1
#    ncpus=1,
    # No. tasks, leave at 1
#    ntasks=1,
    # SET as array
#    chunks.as.arrayjobs=FALSE),
#    workers=5L
#)

plan(multicore, workers=10)

# USE doFuture


registerDoFuture()

# CODE to be executed



data(nsher)

nits <- 10

nsher <- propagate(nsher, nits)

system.time(res <- foreach(i = 1:nits) %dofuture% {
  fmle(nsher)
  dimnames(nsher)$iter[i]
})

save(res, file="~/backup/R/res.RData", compress="xz")
