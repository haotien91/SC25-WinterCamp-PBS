#!/bin/bash
#PBS -N pi-mt-Intel-OMPI
#PBS -P ACD110018
#PBS -q cf160
#PBS -o out.log
#PBS -e err.log
#PBS -l mpiprocs=1000

# Please set NUM_OF_PROCS to 1000 and experiment with various values for TRIES.
NUM_OF_PROCS=1000
TRIES=$(TODO)

module purge
module load gcc/9.3.0
module load mpi/openmpi-4.0.5/gcc930

cd ./sc25-test

make clean && make

echo "Calculat pi by Monte Carlo method with 100000 tries!!"

time mpirun --mca btl ^openib -np $NUM_OF_PROCS ./mpi-monte-carlo.run $TRIES
