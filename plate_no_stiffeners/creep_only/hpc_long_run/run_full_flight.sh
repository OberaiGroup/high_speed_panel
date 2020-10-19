#!/bin/bash
#SBATCH -J flight_48h_48c
#SBATCH --nodes=2
#SBATCH --ntasks=48
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2GB
#SBATCH --time=47:59:00
#SBATCH --mail-user=jlclough@usc.edu
#SBATCH --mail-type=all
#SBATCH --account=aoberai_286
#SBATCH --partition=main

module purge
module load gcc/9.2.0
module load openmpi/4.0.2 pmix/3.1.3 cmake/3.15.4 boost/1.70.0

ulimit -s unlimited

export OMP_NUM_THREADS=48

export dir=/project/aoberai_286/jlclough/high_speed_panel/plate_no_stiffeners/creep_only/hpc_long_run/

cd $dir

mpirun "-n" 48 $ALBANY_EXE ${dir}/input.yaml 

