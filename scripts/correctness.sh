#!/bin/bash
module load openmpi/4.1.4-gcc11
./hw1 1000 5000 > /scratch/$USER/hw1.1000.5000.txt
mpiexec -n 1 hw4_1 1000 5000 1 /scratch/$USER/hw4_1.1000.5000.1.txt
mpiexec -n 1 hw4_1 1000 5000 1 /scratch/$USER/hw4_2.1000.5000.1.txt
mpiexec -n 2 hw4_1 1000 5000 2 /scratch/$USER/hw4_1.1000.5000.2.txt
mpiexec -n 2 hw4_1 1000 5000 2 /scratch/$USER/hw4_2.1000.5000.2.txt
mpiexec -n 4 hw4_1 1000 5000 4 /scratch/$USER/hw4_1.1000.5000.4.txt
mpiexec -n 4 hw4_1 1000 5000 4 /scratch/$USER/hw4_2.1000.5000.4.txt
mpiexec -n 8 hw4_1 1000 5000 8 /scratch/$USER/hw4_1.1000.5000.8.txt
mpiexec -n 8 hw4_1 1000 5000 8 /scratch/$USER/hw4_2.1000.5000.8.txt
mpiexec -n 16 hw4_1 1000 5000 16 /scratch/$USER/hw4_1.1000.5000.16.txt
mpiexec -n 16 hw4_1 1000 5000 16 /scratch/$USER/hw4_2.1000.5000.16.txt
mpiexec -n 20 hw4_1 1000 5000 20 /scratch/$USER/hw4_1.1000.5000.20.txt
mpiexec -n 20 hw4_1 1000 5000 20 /scratch/$USER/hw4_2.1000.5000.20.txt

diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_1.1000.5000.1.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_1.1000.5000.2.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_1.1000.5000.4.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_1.1000.5000.8.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_1.1000.5000.16.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_1.1000.5000.20.txt

diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_2.1000.5000.1.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_2.1000.5000.2.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_2.1000.5000.4.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_2.1000.5000.8.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_2.1000.5000.16.txt
diff /scratch/$USER/hw1.1000.5000.txt /scratch/$USER/hw4_2.1000.5000.20.txt
