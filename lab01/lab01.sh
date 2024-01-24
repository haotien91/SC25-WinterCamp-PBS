#!/bin/bash
#PBS -N pi-mt-Intel-OMPI
#PBS -P ACD110018
#PBS -q cf160
#PBS -o out.log
#PBS -e err.log
#PBS -l mpiprocs=$(TODO)

# Please set TRIES to 100,000 and experiment with different numbers of processes (NUM_OF_PROCS).
NUM_OF_PROCS=$(TODO)
TRIES=100000

module purge
module load gcc/9.3.0
module load mpi/openmpi-4.0.5/gcc930

cd ./sc25-test

make clean && make

echo "Calculat pi by Monte Carlo method with 100000 tries!!"

mpirun --mca btl ^openib -np $NUM_OF_PROCS ./mpi-monte-carlo.run $TRIES
