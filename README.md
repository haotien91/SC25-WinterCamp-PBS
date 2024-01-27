## Hands-on Lab

## PLEASE CLONE IT IN YOUR HOME DIRECTORY.      ~/
### All you need is modifying the $(TODO).

1. Scalability Test.
   * Set TRIES to 1,000,000,000 and measure the performance with different numbers of processes multiple times. Then, use Google Sheets to create a Scalability chart. You will find the output of execution time in .o[JobID] file.
   ```bash
    #!/bin/bash
    #PBS -N pi-OMPI-strong-scale
    #PBS -P ACD112218
    #PBS -q ct160
    #PBS -l mpiprocs=$(TODO)
    
    # Please set TRIES to 1,000,000,000 and experiment with different numbers of processes (NUM_OF_PROCS).
    NUM_OF_PROCS=$(TODO)
    TRIES=1000000000
    
    module purge
    module load gcc/9.3.0
    module load mpi/openmpi-4.0.5/gcc930
    
    cd ./SC25-WinterCamp-PBS
    
    make clean && make
    
    echo "Calculat pi by Monte Carlo method with 1,000,000,000 tries!!"
    
    mpirun -np $NUM_OF_PROCS --mca btl_openib_allow_ib=1 ./mpi-monte-carlo.run $TRIES
   ```


2. Absolute Error Test.
   * Keep the number of processes constant at 20, and vary the number of TRIES. Then, create a chart to show how the error changes with different TRIES values. You will find the output of abs error in .o[JobID] file.
   ```bash
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
    
    time mpirun -np $NUM_OF_PROCS --mca btl_openib_allow_ib=1 ./mpi-monte-carlo.run $TRIES
   ```
