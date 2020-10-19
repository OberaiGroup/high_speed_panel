#!/bin/bash
#SBATCH -J pure_mpi
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2GB
#SBATCH --time=01:00:00
#SBATCH --mail-user=jlclough@usc.edu
#SBATCH --mail-type=all
#SBATCH --account=aoberai_286
#SBATCH --partition=main

module purge
module load gcc/9.2.0
module load openmpi/4.0.2 pmix/3.1.3 cmake/3.15.4 boost/1.70.0

ulimit -s unlimited

export OMP_NUM_THREADS=1

export cores=2
export dir=/project/aoberai_286/jlclough/high_speed_panel/plate_no_stiffeners/creep_only/hpc_SLUD_scaling/$cores

cd $dir

time ( mpirun "-n" $cores $ALBANY_EXE input.yaml >> ${dir}/run_output_${cores}.txt 2>&1 ) >> ${dir}/time_output_${cores}.txt 2>&1

