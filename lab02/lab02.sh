#!/bin/bash
#PBS -N pi-OMPI-abs-err
#PBS -P ACD112218
#PBS -q ct160
#PBS -l mpiprocs=20

# Please set NUM_OF_PROCS to 20 and experiment with various values for TRIES.
NUM_OF_PROCS=20
TRIES=$(TODO)

module purge
module load gcc/9.3.0
module load mpi/openmpi-4.0.5/gcc930

cd ./SC25-WinterCamp-PBS

make clean && make

echo "Calculat pi by Monte Carlo method with $TRIES tries!!"

time mpirun --mca btl ^openib -np $NUM_OF_PROCS ./mpi-monte-carlo.run $TRIES
