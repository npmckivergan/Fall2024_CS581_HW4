#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <mpi.h>

#define DEAD 0
#define ALIVE 1

// Count alive neighbors around a cell
int count_neighbors(int **grid, int x, int y) {
    int alive_count = 0;
    for (int i = x - 1; i <= x + 1; i++) {
        for (int j = y - 1; j <= y + 1; j++) {
            if (i != x || j != y) {
                alive_count += grid[i][j];
            }
        }
    }
    return alive_count;
}

// Update grid to the next generation
bool update_generation(int **current, int **next, int rows, int cols) {
    bool changed = false;
    for (int i = 1; i < rows - 1; i++) {
        for (int j = 1; j < cols - 1; j++) {
            int alive_neighbors = count_neighbors(current, i, j);
            next[i][j] = (current[i][j] == ALIVE) ? 
                         ((alive_neighbors == 2 || alive_neighbors == 3) ? ALIVE : DEAD) : 
                         (alive_neighbors == 3 ? ALIVE : DEAD);
            if (current[i][j] != next[i][j]) changed = true;
        }
    }
    return changed;
}

// Swap pointers to the grids
void swap(int ***a, int ***b) {
    int **temp = *a;
    *a = *b;
    *b = temp;
}

int main(int argc, char *argv[]) {
    MPI_Init(&argc, &argv);
    int rank, world_size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &world_size);

    double start;
    double end;

    if (argc != 5) {
        if (rank == 0) printf("Usage: ./hw4 <grid size> <max generations> <processes> <output>\n");
        MPI_Finalize();
        return 1;
    }

    int grid_size = atoi(argv[1]), generations = atoi(argv[2]);
    char *output_path = argv[4];

    int local_rows = grid_size / world_size + (rank < grid_size % world_size);
    int total_rows = local_rows + 2, total_cols = grid_size + 2;

    int **current = (int **)malloc(total_rows * sizeof(int *));
    int **next = (int **)malloc(total_rows * sizeof(int *));
    for (int i = 0; i < total_rows; i++) {
        current[i] = (int *)calloc(total_cols, sizeof(int));
        next[i] = (int *)calloc(total_cols, sizeof(int));
    }

    int *recv_data = (rank == 0) ? malloc(grid_size * grid_size * sizeof(int)) : NULL;
    if (rank == 0) {
        for (int i = 0; i < grid_size * grid_size; i++) {
            recv_data[i] = rand() % 2;
        }
    }

    int *recv_counts = malloc(world_size * sizeof(int));
    int *recv_displs = malloc(world_size * sizeof(int));
    int rows_offset = 0;
    for (int i = 0; i < world_size; i++) {
        recv_counts[i] = (grid_size / world_size + (i < grid_size % world_size)) * grid_size;
        recv_displs[i] = rows_offset;
        rows_offset += recv_counts[i];
    }

    int *local_data = malloc(local_rows * grid_size * sizeof(int));
    MPI_Scatterv(recv_data, recv_counts, recv_displs, MPI_INT, local_data, local_rows * grid_size, MPI_INT, 0, MPI_COMM_WORLD);

    for (int i = 0, idx = 0; i < local_rows; i++) {
        for (int j = 0; j < grid_size; j++) {
            current[i + 1][j + 1] = local_data[idx++];
        }
    }

    free(local_data);
    if (rank == 0) free(recv_data);

    int up = (rank > 0) ? rank - 1 : MPI_PROC_NULL;
    int down = (rank < world_size - 1) ? rank + 1 : MPI_PROC_NULL;

    bool changes = true;
    int gen = 0;
    if (rank == 0) {
        start = MPI_Wtime();
    }
    while (gen < generations && changes) {
        MPI_Sendrecv(current[1], total_cols, MPI_INT, up, 0,
                     current[total_rows - 1], total_cols, MPI_INT, down, 0,
                     MPI_COMM_WORLD, MPI_STATUS_IGNORE);

        MPI_Sendrecv(current[total_rows - 2], total_cols, MPI_INT, down, 1,
                     current[0], total_cols, MPI_INT, up, 1,
                     MPI_COMM_WORLD, MPI_STATUS_IGNORE);

        changes = update_generation(current, next, total_rows, total_cols);

        int local_changed = changes ? 1 : 0, global_changed;
        MPI_Allreduce(&local_changed, &global_changed, 1, MPI_INT, MPI_SUM, MPI_COMM_WORLD);
        changes = global_changed > 0;

        swap(&current, &next);
        gen++;
    }
    if (rank == 0) {
        end = MPI_Wtime();
    }

    int *final_data = malloc(local_rows * grid_size * sizeof(int));
    for (int i = 0, idx = 0; i < local_rows; i++) {
        for (int j = 0; j < grid_size; j++) {
            final_data[idx++] = current[i + 1][j + 1];
        }
    }

    int *gather_counts = NULL, *gather_displs = NULL, *gathered_data = NULL;
    if (rank == 0) {
        gather_counts = malloc(world_size * sizeof(int));
        gather_displs = malloc(world_size * sizeof(int));
        rows_offset = 0;
        for (int i = 0; i < world_size; i++) {
            gather_counts[i] = recv_counts[i];
            gather_displs[i] = rows_offset;
            rows_offset += gather_counts[i];
        }
        gathered_data = malloc(grid_size * grid_size * sizeof(int));
    }

    MPI_Gatherv(final_data, local_rows * grid_size, MPI_INT, gathered_data, gather_counts, gather_displs, MPI_INT, 0, MPI_COMM_WORLD);

    if (rank == 0) {
        FILE *out = fopen(output_path, "w");
        if (!out) {
            perror("Output file error");
            MPI_Abort(MPI_COMM_WORLD, 1);
        }
        for (int i = 0; i < grid_size * grid_size; i++) {
            fprintf(out, "%c ", gathered_data[i] == ALIVE ? '1' : '0');
            if ((i + 1) % grid_size == 0) fprintf(out, "\n");
        }
        fclose(out);
        free(gather_counts);
        free(gather_displs);
        free(gathered_data);
    }

    free(recv_counts);
    free(recv_displs);
    free(final_data);
    for (int i = 0; i < total_rows; i++) {
        free(current[i]);
        free(next[i]);
    }
    free(current);
    free(next);

    if (rank == 0) {
        printf("Completed after %d generations\n", gen);
        printf("Elapsed time: %f seconds\n", end - start);
    }

    MPI_Finalize();
    return 0;
}
