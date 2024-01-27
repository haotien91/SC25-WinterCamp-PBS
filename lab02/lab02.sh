#!/bin/bash
#PBS -N pi-OMPI-abs-err
#PBS -P ACD112218
#PBS -q dc20240001
#PBS -l nodes=1:ppn=20

# Please set NUM_OF_PROCS to 20 and experiment with various values for TRIES.
NUM_OF_PROCS=20
TRIES=$(TODO)

module purge
module load gcc/9.3.0
module load mpi/openmpi-4.0.5/gcc930

cd ./SC25-WinterCamp-PBS

make clean && make

echo "Calculat pi by Monte Carlo method with $TRIES tries!!"

mpirun -np $NUM_OF_PROCS --mca btl_openib_allow_ib=1  ./mpi-monte-carlo.run $TRIES
