#!/bin/bash
#PBS -N pi-OMPI-strong-scale
#PBS -P ACD112218
#PBS -q dc20240001
#PBS -l nodes=1:ppn=$(TODO)

# Please set TRIES to 1,000,000,000 and experiment with different numbers of processes (NUM_OF_PROCS).
NUM_OF_PROCS=$(TODO)
TRIES=1000000000

module purge
module load gcc/9.3.0
module load mpi/openmpi-4.0.5/gcc930

cd ./SC25-WinterCamp-PBS

make clean && make

echo "Calculat pi by Monte Carlo method with 1,000,000,000 tries!!"

mpirun -np $NUM_OF_PROCS --mca btl_openib_allow_ib=1  ./mpi-monte-carlo.run $TRIES
