#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>
#include <math.h>

#define PI 3.14159265358979323846

typedef unsigned long long ull;

int main(int argc, char* argv[]) {
    int rank, size;
    ull n, local_count = 0, global_count;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    if (argc != 2) {
        if (rank == 0) {
            fprintf(stderr, "Usage: %s <number_of_points>\n", argv[0]);
        }
        MPI_Finalize();
        return 1;
    }

    n = strtoull(argv[1], NULL, 10);

    // Start the timer
    double start_time = MPI_Wtime();

    unsigned int seed = time(NULL) + rank;
    for (ull i = rank; i < n; i += size) {
        double x = (double)rand_r(&seed) / RAND_MAX;
        double y = (double)rand_r(&seed) / RAND_MAX;
        if (x * x + y * y <= 1.0) {
            local_count++;
        }
    }

    MPI_Reduce(&local_count, &global_count, 1, MPI_UNSIGNED_LONG_LONG, MPI_SUM, 0, MPI_COMM_WORLD);

    // Stop the timer
    double end_time = MPI_Wtime();

    double local_execution_time = end_time - start_time;
    double max_execution_time;
    MPI_Reduce(&local_execution_time, &max_execution_time, 1, MPI_DOUBLE, MPI_MAX, 0, MPI_COMM_WORLD);

    if (rank == 0) {
        double pi = 4.0 * global_count / n;
        printf("Estimated Pi = %f\n", pi);
        printf("Absolute Error = %f\n", fabs(pi - PI));
        printf("Max Execution Time = %f seconds\n", max_execution_time);
    }

    MPI_Finalize();
    return 0;
}
