#!/bin/bash
module load openmpi/4.1.4-gcc11

mpiexec -n 1 hw4_1 5000 5000 1 /scratch/$USER/discard.txt
mpiexec -n 1 hw4_1 5000 5000 1 /scratch/$USER/discard.txt
mpiexec -n 1 hw4_1 5000 5000 1 /scratch/$USER/discard.txt
mpiexec -n 2 hw4_1 5000 5000 2 /scratch/$USER/discard.txt
mpiexec -n 2 hw4_1 5000 5000 2 /scratch/$USER/discard.txt
mpiexec -n 2 hw4_1 5000 5000 2 /scratch/$USER/discard.txt
mpiexec -n 4 hw4_1 5000 5000 4 /scratch/$USER/discard.txt
mpiexec -n 4 hw4_1 5000 5000 4 /scratch/$USER/discard.txt
mpiexec -n 4 hw4_1 5000 5000 4 /scratch/$USER/discard.txt
mpiexec -n 8 hw4_1 5000 5000 8 /scratch/$USER/discard.txt
mpiexec -n 8 hw4_1 5000 5000 8 /scratch/$USER/discard.txt
mpiexec -n 8 hw4_1 5000 5000 8 /scratch/$USER/discard.txt
mpiexec -n 16 hw4_1 5000 5000 16 /scratch/$USER/discard.txt
mpiexec -n 16 hw4_1 5000 5000 16 /scratch/$USER/discard.txt
mpiexec -n 16 hw4_1 5000 5000 16 /scratch/$USER/discard.txt
mpiexec -n 20 hw4_1 5000 5000 20 /scratch/$USER/discard.txt
mpiexec -n 20 hw4_1 5000 5000 20 /scratch/$USER/discard.txt
mpiexec -n 20 hw4_1 5000 5000 20 /scratch/$USER/discard.txt

mpiexec -n 1 hw4_2 5000 5000 1 /scratch/$USER/discard.txt
mpiexec -n 1 hw4_2 5000 5000 1 /scratch/$USER/discard.txt
mpiexec -n 1 hw4_2 5000 5000 1 /scratch/$USER/discard.txt
mpiexec -n 2 hw4_2 5000 5000 2 /scratch/$USER/discard.txt
mpiexec -n 2 hw4_2 5000 5000 2 /scratch/$USER/discard.txt
mpiexec -n 2 hw4_2 5000 5000 2 /scratch/$USER/discard.txt
mpiexec -n 4 hw4_2 5000 5000 4 /scratch/$USER/discard.txt
mpiexec -n 4 hw4_2 5000 5000 4 /scratch/$USER/discard.txt
mpiexec -n 4 hw4_2 5000 5000 4 /scratch/$USER/discard.txt
mpiexec -n 8 hw4_2 5000 5000 8 /scratch/$USER/discard.txt
mpiexec -n 8 hw4_2 5000 5000 8 /scratch/$USER/discard.txt
mpiexec -n 8 hw4_2 5000 5000 8 /scratch/$USER/discard.txt
mpiexec -n 16 hw4_2 5000 5000 16 /scratch/$USER/discard.txt
mpiexec -n 16 hw4_2 5000 5000 16 /scratch/$USER/discard.txt
mpiexec -n 16 hw4_2 5000 5000 16 /scratch/$USER/discard.txt
mpiexec -n 20 hw4_2 5000 5000 20 /scratch/$USER/discard.txt
mpiexec -n 20 hw4_2 5000 5000 20 /scratch/$USER/discard.txt
mpiexec -n 20 hw4_2 5000 5000 20 /scratch/$USER/discard.txt
