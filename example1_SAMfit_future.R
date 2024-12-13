
library(FLCore)
library(FLSAM)
library(stockassessment)
library(doFuture)
library(future.batchtools)

load('./data/NSH_data.RData')

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

plan(multicore, workers=1)

registerDoFuture()

# CODE to be executed


message("Running on ", nbrOfWorkers(), " nodes.")

nits <- 10

NSH <- propagate(NSH, nits)

NSH.tun <- lapply(NSH.tun,propagate,nits)

system.time(
  res <- foreach(i = 1:nits) %dofuture% {
    capture.output(out <- tryCatch(
      FLSAM::FLSAM(iter(NSH,i),
                        lapply(NSH.tun, function(x) iter(x,i)),
                        NSH.ctrl),
      error = function(e) {
        NULL
      }),file=nullfile())
  }
)

save(res, file="./res.RData", compress="xz")
